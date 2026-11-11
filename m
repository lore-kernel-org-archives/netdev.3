Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794421449;
	b=afhZR3eXlg1IAOGDQf1jokzN55/cdBbEKxMl9kKG5OMPolq96ELc5FlAzKel8lC2b/Jr
	 2kHkrbD65Sfs/FXcDu/nDzpUfWe2A/7hkCCSJ1od4K9et940Hs4T/O3xi47uckgMNqBFF
	 X+QxOZ5B040EhBpiSJll4zydpgnKLUQDk/pmvVHiWTJa43uZr3JvD7ySrzUQa+oGfBxx/
	 yqSDBI4FTr4BaWU5VkrgV4fOYGwj/b/mY0n8sMypbq2OaedZFcBfs1ZxfUxLwbXlB362q
	 lgRrp0Xbnf7GWDONog2o3JjmwjSpgRmjRnzdfiWUGcUvycfOuuYbPyP4CrEnAdzxpMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421449;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=aMG9NSIoryJ6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=;
	b=fk5m6vK0oqS+Ff+aunwn4yUux6/76Atev4KOf+nUCBUlqaz77l6/Dift2PPK0t0SBRIj
	 90vvbjq2w35ybYyk7QMqawZ0EUEcSJ89LBVAAar5eXgL70HKCNtU0emuws0nuSsRFOr4n
	 1N+PYwf9gscGX4PJvbU8BtDYNa0146esnbPd6AZngWuoB09AFLLC7l/oXGY4IQtjAwq+j
	 KMSJvHLEJirqM8EmCN3k8fMIFGzYa4Zp2O4e3r8LjSTrXCWeUTAuaYHZmbd9M3sNzzwwu
	 xK0isHTXOGmPsImOAG2Zout8P4FuBvf/4b2yHZflGYMybo7c233dcxtLap9lbkGY0hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=isns6Mqh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FF606A334
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2FF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=isns6Mqh
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHskCb1222790
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:24:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=aMG9NSIoryJ
	6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=; b=isns6MqhLK2gICBmvsfmHDefPrM
	fcse+kjR+dgFtXbRypDtqotW1Yl02H8zLF60ugJCdMKKjv2bgp3/FfDVbtAj0qPL
	nMdiMIQxDW/X1fu1xFPQrqO7h+9kKGnsak6+fIA8XRHkd2ZnZxPL61j+PZEgibEy
	nBb5hifSwAd17cHCObGIGWr6WQCyzXxmQufY6UHIk7KcX4LXVPfTsiACYBolCFv2
	uZsIapcgbM6aipiYch9uLbCT+xrDb7WMyVR20uj/cvl1DYR6dMROu6AKFq/+SWeu
	7vwmmqM2W1TLALIA4l+/gOuarfulif/2FeT4KQUkwmvzHlyXdH6HmkOe6Mg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hv85sh1f4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:24:08 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so5719841a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794421448; cv=none;
        d=google.com; s=arc-20260327;
        b=HpiBILIYFvubsx1h7qSSb+YnWZ4UjjUYRhYscbza0wPyyYTs28QrzO6egQkniSd+4L
         K8JKdC0rYDDt6s4uFSbSJP8hugBGBmTHjxHIuHRx12hcOb0K/2VJI6oZKOQVMP18PQXv
         9HJQE9eSo0ASb8/QWcw307t68+hzZ1SFcD+Pk5SLQkR4SnE+iORqzsOunSIjSyEN3rcu
         olriOYSjiWigR7xdrK0C8MwLC9j4fyCHLeo7tKUnOfXIpq7AjCulOOKEcwi9t+sN/f+E
         YDTy59V7kta1rdHcyIlVJ2kbdE57EX5ARIVrw6/G3rVLAqVnrFh+hHXvI2p/ZDyy4ICv
         9LGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=aMG9NSIoryJ6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=;
        fh=Pmj0flJu1UnzQXPteF+BeXRUrdGICr8j0xYNarx7zbU=;
        b=B7GZbknic27U0bAGEzhUyJX7LYm4RDJKxk9vIz57/fR8bOoUTXTxVnWRtSkOa/sXVM
         yO425D0niM4kzWbGVF2y/sLOVzkbIWj+LR2l5bh1/ARxvdtjR1R29WUhhHQjV71iSOqq
         NTmnke3E5fvcOG8Mkdc+uYHaV+OnmRZm20goSz05qHk+9R2+8FIMM/DJnQJG3XoMn/Ch
         y4uhwuWvDJ0jZx8yNKeznKkVreheZHbp1gUWMLlxQvuw1dUwk6wP7pynnH+heQfn3Cp9
         Vc2Y7wBUF34tDiMq76r20oDFN+dcJRXmO240WRsQHtmvTgld3Dao37Vqae9KgQ/S8iz3
         FN4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421448; x=1795026248;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aMG9NSIoryJ6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=;
        b=O9fztJ3Ba9dPbcgJA7/BwhnpiXcwAH3T48p/6p7ZcC5x/qneEdAp0rnZqqCjzrh1QT
         wGTpdX3q0OluoSe8KjuDEs27hDaVajHkF8PDjvcF+LzS0iiCr9gTxku5OLRMFEuLHbx9
         /1jQfeTNwnU06rvKXUs8ZtQxe/vLKGH2+HzOetRp/JgIGevLVVYvxKqlyrYHqp+IPTe8
         IJcvN+xia7miAZJ8i0NURibaOcqmRYYhfmK4FavKkqcpaWDivVenU+n+12nAKhNdqUYE
         z4LhzTRyGvnZVlucS52uLO5bPM733qKCAexdHGpWvtkAzztjkyIJMX9NQF21xj08sisf
         fcCA==
X-Gm-Message-State: APuU4Z/16qvKAvNipnpy1Em6phJ80SkbvT2WWOUidSCl5YmM9K6RbSLB
	K31yMx3MfsM5LuRaAFi8rLS/AZTgv2U3gYHhW99uqATRssNmO/MeGrW16TPUasrGLkVtR8GjCAS
	+qlNMt6AvtTI7eiVLY9+JHnF6hZiaMiXePcwJVMQhV0SlN9xPAWRsdYpREjeF9BeFtZS5pq6Hhp
	HvR5Yysl8Ub0wRP719Axl64+D2846qrbM=
X-Gm-Gg: AYBFou1EVsTyjgKsPfo2IBpWfqphpk+P7EFttzfuoDGLM1WXzI8bytlDyluo0RttYSP
	HOStsH5nhRFVYQ7LM1wcUIFBcT+22AKuqz7q+koeTdbm/x5/MbN6phZPLSzf0uirXOykvjE0P1W
	e8tOsS1YbTdsvmzlIlxYs1fRf7s5x2EUeXTxjkfMbS6IdHS1eUSTdVrufxytRlRxJqrefvWFcZQ
	oTghwAbtgP+zuZdo7JvwD+k6wiSOFDj
X-Received: by 2002:a17:90b:2f83:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3b182eda7efmr3257443a91.26.1794421447581;
        Wed, 11 Nov 2026 10:24:07 -0800 (PST)
X-Received: by 2002:a17:90b:2f83:b0:3ab:884b:65a8 with SMTP id
 98e67ed59e1d1-3b182eda7efmr3257421a91.26.1794421447127; Wed, 11 Nov 2026
 10:24:07 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-5-toddfreed@meta.com>
 <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
In-Reply-To: <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 10:23:56 -0800
X-Gm-Features: AclHuK8_olqmA7fXTYgEAj2-H4kgkwQj_X0uL-xyG8nZrZvhci79BGaB7ila0uo
Message-ID: <CADh2yMx8MPjcH7Bpj72rNNd_tT=6uSC5Ow9JyGjTMjFgs499Pw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/15] psp: add support for socket-less psp associations
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: Kai6dCsmrunecvxQrxn3g9KpAA6-XuQ5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfX/hSQllmZ1jkJ
 Oc9Ms2flYrUM3VghNPdEy/linv6hhBihy1j5Jwkww9zVTivdRMr8PTQNs88sECfEidcHrnRt+LJ
 ZnDibGn2DHOdhbIXs8n2SrWUzeoHSYc=
X-Authority-Analysis: v=2.4 cv=RsZQvymK c=1 sm=1 tr=0 ts=6af4b2c8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=-xR6GoDS8vL2zpuMsZwA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfX8UZPHdxLMiXs
 UOrQQ73/kdqx8LKV26TT4HuVqPbB3fJmem4kbBuWw8QjlfiSro6CKSIARgXQFi3bjQ+C/Urs2J0
 4KMERT+U+lXhnCCRqba/skH++NYTaN/wvlMaxDIX/TiwRaF6caN9y16BKP5P8eaoedtHvOyYRuO
 cC57jH6N6PfLG5UvSEqK3GE5uACM0D733A4UhRHyCgGklW5WQ6BTsd9V9zul+0rHzao2Mu2+qIU
 5ZaumcP+LvCfbKc9igECapKKSFJQYWSvhMSPJ2cBAcMAFq+VuUFQ9AU+y0CAoqVimz4iImkjb/f
 z91kO2q1s8ecVv1ktG0fSMBW4nWDJN8JxAuwJucXOOQw0WE9+RtZCRDpya93LzVIZUxguY7pirT
 PAHXyuDyTx1WzQ59HTxA5EYfNw6DhM+c1LbnPEAGkb319nLcPVT458REGMhkaEPR7HRCHCwJT+7
 gbC9id5c2CX+b9PjCBg==
X-Proofpoint-ORIG-GUID: Kai6dCsmrunecvxQrxn3g9KpAA6-XuQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01

> I'm not sure the kernel actually needs any bookkeeping at all for these
> generic rx spi allocations. You could probably just pass the spi, dev
> id, key, and probably rotation count (as a device key generation of
> sorts) to the user without creating a kernel object. For socket
> psp_assocs, the rx state is consulted on the datapath before queueing to
> the socket. For tx state in all psp_assocs, there is the possibility
> that an SADB handle needs to be cleaned up. Neither of those apply here
> or in the rest of the series as I understand it.
>
> I figure the tc ingress rule can just take the spi and dev id by value
> rather than needing a reference to an object that we create here.

That is how it works in this series. The tc psp decap rule (ingress) does not
make reference to an rx assoc ; instead, it should have flower matches on
psp_spi, psp_ver, and psp_dev. That effectively ties it to packets from just
one rx assoc.

So why keep track of rx assoc objects at all? Two considerations.

1/ don't accept packets that correspond to a stale association. That is, even
if the device decrypted the packet, it should be dropped if the device key
which minted the assoc's SPI is two rotations behind. For psp socket offload
that is enforced in __psp_sk_rx_policy_check() with the pas->generation
check.

The spec permits SPIs to be reused immediately after two rotations. So the
device could decrypt a packet with a SPI that is more than two rotations old
in that case, or if a previous packet is being replayed, for example.

2/ hardware offload. the solution to #1 should be able to be fully offloaded
to the device. psp tunnel mode will be hw offload only, and is implemented
in the eswitch with connect-x.

We could add a psp_gen flower match to replicate the pas->generation
check, but the device has no access to the pas and can't offload that.

Keeping track of the rx assoc means that the kernel can take action on the
"this assoc is now stale" event. Possibly by enumerating the tc rules and
either deleting them, or marking them stale for userspace to reap.

-Todd
