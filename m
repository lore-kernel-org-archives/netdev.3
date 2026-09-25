Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E454CDA27
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359226; cv=none; b=Lfm1BtgeMmFxUmG7MOXTcnpu3aXQaZIn23IEV1TMRQkevjrwVIaswG1RE6SX6gn0A0Iuvr2zmZ9N7vRsy9bjurZ0M7CuzEPpEmbKosRaKSZA9UYtCtDMTUUyQ+wqjjWTK9Iyx8mmNN5VRD3Uor0/IrN2rMpWlGo81ltJjCYx2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359226; c=relaxed/simple;
	bh=M9UoQCdjwhMIILlp6xRomgfQpLsegpc4Cg0agBunOCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou5JwIW2LUBKt02DszAwYKULNZPOVgNdAkwD0sQQ5TkylCD6wGQKVe1aXEl7Cs4Z3DYUWuswN6E9e6AVOE2UfwiT1NfL7jXXcDgegN8ExWmaCb+e1YP8eInIakz6wuX3w5oOq3rlpeGmjILpTguP8B6IzkWPC0tqYpqqvBCTSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBm8KtES; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBm8KtES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790359219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5+K7rqIv0VRxt/7gRrgH9vu2jfj/02HPAR5DN47kQY=;
	b=IBm8KtESGQ+C//bA0TrWwMNPHNr9rgi4RETBHAYU+qKyJTb/lFD14hg7BDMpr88q1ZtGNE
	OyAHfHhlSukvbN1Nj6I9KXosdA+l43RrXnY0WHoWTjYQfbaqPQ0WdHSbDlUcKe3WYSviHi
	nH5LCT3i6ZOydmsIMY4G5lopC7dP1J8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-JoVPPpGeOWyZ5Q3xkOEW6w-1; Fri,
 25 Sep 2026 14:00:14 -0400
X-MC-Unique: JoVPPpGeOWyZ5Q3xkOEW6w-1
X-Mimecast-MFC-AGG-ID: JoVPPpGeOWyZ5Q3xkOEW6w_1790359212
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E507719539A2;
	Fri, 25 Sep 2026 18:00:11 +0000 (UTC)
Received: from [100.90.87.156] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E277C41D;
	Fri, 25 Sep 2026 18:00:08 +0000 (UTC)
Message-ID: <d7c2c701-cfca-4d97-bee7-757b6f31f0d8@redhat.com>
Date: Fri, 25 Sep 2026 20:00:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] netlink: specs: dpll: declare pad in the
 nests which carry 64-bit values
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, donald.hunter@gmail.com
References: <20260924231211.568213-1-kuba@kernel.org>
 <20260924231211.568213-3-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260924231211.568213-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95



On 9/25/26 1:12 AM, Jakub Kicinski wrote:
> Pads need to be propagated to subsets if they are used.
> Otherwise Python YNL can fail with:
> 
>    YnlException: Space 'frequency-range' has no attribute with value '4'
> 
> This affects only platforms which care about alignment
> so not much real impact.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/netlink/specs/dpll.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index e2ca4df5699a..7009a64473b1 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -550,6 +550,8 @@ doc: DPLL subsystem.
>       attributes:
>         -
>           name: parent-id
> +      -
> +        name: pad
>         -
>           name: direction
>         -
> @@ -576,6 +578,8 @@ doc: DPLL subsystem.
>       name: frequency-range
>       subset-of: pin
>       attributes:
> +      -
> +        name: pad
>         -
>           name: frequency-min
>         -

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

