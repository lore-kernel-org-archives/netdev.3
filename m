Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4441DECF
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127781; cv=none; b=DEThuBtDT5JZeLAHl/qOZaWnR0vS3vlvDcRlznvmP+RtMKID59glvDaHtXjCzRZOuLMOFOKeM/EJh/KkZcCvnWGhGBhMegyJ87twYE8LEJNz8E2NvnrWE5+CCQF8SfJbPVHCgQqDvNcywq9juxWE0sxQft17G+ToUgqcZM1s3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127781; c=relaxed/simple;
	bh=BT4NCCefGBEHg9Oqy1ef01/bhz/T6gxhIP1pP8s+y1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IROsDyewSUzqLQ/v7zI7sV3EKciKflzQPL9R/TebuFmxhjNuu5ZjYvZ9sIdSPuCdie84JvAGDo9BkauztbgRVY1mDIZXPBL5VtwX2z6R2iiHdLXo06zpvrMIlEUlp4TESummMlzvgXsbz0ub+qZMQ7a/dDHNkaOMUtM9ZFxcNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJzhNnpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJzhNnpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636531F00A3A;
	Wed, 15 Jul 2026 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784127780;
	bh=wDNmqqm3V2brDMwyu7i/iBciQvN4pYkMed4wykoEK6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RJzhNnpGnWYQ5RcTbk1utzRvoSZDYMpXu59ptMyCf5R/AGY4tAIJ5AYDXi1CkTDoC
	 y6ZrUIMNKaSBEU7Cv1L/jfK2gaPG/Dxxe18CAChv2eTJbpwf+Tdtyfwcpvm/pTnJku
	 Ci29pLVmweh26/+iHtPymFpWYKW8/WVlXgWePq0zHpPl2cH8Eee8nWVRoX1izras0u
	 D590sSfgfjgHMAZTBBrwPj+aW0ln8PQtDzXT3ts4sad+7PhEuknaLdOCD13vAJ5yM6
	 hzpn6W9B+BlPLgzB4CHQTHI7ZWa0YSgcBI5ZI8GuRD7tGW8iWnacJ8ZmjgYxnkmouP
	 CH7wmMdlxVjcA==
Message-ID: <01009484-2a68-4b44-b742-bee13bbb08b2@kernel.org>
Date: Wed, 15 Jul 2026 09:02:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ipmaddr: use RTM_GETMULTICAST to list
 multicast addresses
Content-Language: en-US
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: netdev@vger.kernel.org
References: <20260711030733.48567-1-sigefriedhyy@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260711030733.48567-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/26 9:07 PM, Yuyang Huang wrote:
> +static int accept_maddr(struct nlmsghdr *n, void *arg)
> +{
> +	struct maddr_dump_ctx *ctx = arg;
> +	struct ifaddrmsg *ifm = NLMSG_DATA(n);
> +	int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*ifm));
> +	struct rtattr *tb[IFA_MAX + 1];
> +	struct ma_info *ma;
> +
> +	if (n->nlmsg_type != RTM_GETMULTICAST &&
> +	    n->nlmsg_type != RTM_NEWMULTICAST)
> +		return 0;

From claude (and I agree with the finding)

> +static int accept_maddr(struct nlmsghdr *n, void *arg)
> +{
> ...
> +     if (n->nlmsg_type != RTM_GETMULTICAST &&
> +         n->nlmsg_type != RTM_NEWMULTICAST)
> +             return 0;

The kernel replies to a RTM_GETMULTICAST dump request with
RTM_NEWMULTICAST messages — it never sends RTM_GETMULTICAST in a
response.  Including RTM_GETMULTICAST in the guard is dead code and is
confusing; it inverts the usual convention used everywhere else in
iproute2 (e.g. ipaddress.c always checks RTM_NEW* / RTM_DEL*, never
RTM_GET*).

Should be:

        if (n->nlmsg_type != RTM_NEWMULTICAST)
                return 0;


