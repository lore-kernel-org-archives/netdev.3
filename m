Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC82D9ECA
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786328912; cv=none; b=ivOvTdvkAQeBl+R2aUqNe/3b1v9uV76PILEeCikc3LNkt1SVmIX9SL54dTJSQ4XUTGQdUGpVqi7nL9zZGjRLucBnraLRs6JTlDqeGX+aTKKQBykqhGBQnNp8HV2wicxUFrK+iEd2j0/Zl47ompArWYoKuUYazUO9nMAok3GCuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786328912; c=relaxed/simple;
	bh=tJzmd3IEv39tmOy//Ct/ijtrwTC9s/C0oLITnlyYSSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf1XRMrFOcjo3QfNrN1HS9fbmaUOjvLAP3ahW4Bg97lRK/5csS/Be2D/ZRugBnEvKv2mHSiazKEkO1AGWYinmINrpBwLziWX/o9h4YUfRzGY1e1+eKhU5PQALFPks0mhCn5aIpeAqZRWiBkWjTj6u/zutSrolI6h2GPxu4q8/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wgnc6J9L; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wgnc6J9L"
Message-ID: <26e0b578-0f8f-49f6-aaa6-b814c89ebe3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786328899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pSgPwGVNwWgWWDZniLJ/YHoFfWsO/JdFCuSXp4+4VU=;
	b=wgnc6J9LSd+bNCM5EKs801ib/VM+kq3G9Pg+PxtsdexevVFZ23L8f3DP3W0+Y2OvJVKznC
	7IkStHmT9Z2o8+vuxj3rZ4vIVsZU7YWZ9p/v3OjWY52faI+/OyJuV70tpIC0iSUrdXXSIk
	u6ZeJuPE8hwEdmQjjd2cSIMqy6sdi8o=
Date: Mon, 10 Aug 2026 10:28:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next] pppoe: remove session socket receive support
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Guillaume Nault <gnault@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, Asim Viladi Oglu Manizada <manizada@pm.me>,
 Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Michal Ostrowski <mostrows@gmail.com>
References: <20260806091626.231225-1-qingfang.deng@linux.dev>
 <20260809145836.5pqf2rgf574fjlds@pali>
 <76232f9c-2a5a-454a-905e-e046b6c78cef@linux.dev>
 <20260809225954.i36fajv6twbnjfdp@pali>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260809225954.i36fajv6twbnjfdp@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026/8/10 6:59, Pali Rohár wrote:
> I see. Maybe you could ask developers of the first version of driver if
> they remember something. But probably nobody would remember old things.

I wish I could, but the maintainer of PPPoX has gone AWOL for quite a 
long time.. (commit 2fd68c7ea2ae)

> Clearing the queue after the transition happens sounds like a good idea.
> If I understand correctly, it does not make sense to get packets into
> userspace once the socket is bound to PPP layer.
>
> I have feeling that kernel PPP layer and its API do fully fit into the
> API for network devices and netlink layer for userspace.
