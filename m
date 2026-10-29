Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271124;
	b=Dv+J8LY+0Dd5Sc1sYyLQ6DCZGF0L8nBG+prPTe8hwz6eDCsvNoCob6i0LQzEy1+hPSwa
	 pfUhArqmIPqeDp+IetwlNFt9lJ6XhhfKPn6D7bcdZaOkaLIYsy4DJVrtfpekd0fVa5cqd
	 01udmuuyxTMF1x3UGCcH+sxs2vgJ+/XNyMoh7p+3Pbq+rKKMK29KSHhzqzjnWLoxG5xTL
	 yPWaojVHPtVmMMb9Tvo++kYU77bi9Hs0a7BY63gL/Zkw3Zt1/+jH2BGMQ3RfH5v1as8qz
	 YybLKL13zj5EwbnEqZnmBEXOXHzvHkkMRFSm9sD/Xt5UPaQpjinrJl+5jijEIqZXkCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iymo6yWih1u6JSkjazwtYJq1W+j31tigL1sbJo3i2bo=;
	b=DpyEuJMlP2UftR0mJgXe8hmQOB2BuH3G8CDcb4YIy/wcaaNFBD0/1dYI+sE/7Wtg4jEi
	 krpVqJWGYAp8S4Dmpa4fJCMBR+feCJzxnxyhg9UEmOIHX4D4fgEiarP3I0shZQ3k8JOh6
	 UFW1zbP9doT5zGilHlRtMmLqxrUz4KgVh9mRR2KaOPRQkeh4f6squcjHShrkMvNMUi+gM
	 K0hWqeDs3XX7M4F6PO/PBGyKGIOzgqy/V1SdW06PwLZdRyS3bPqChwgk3dbW21t3zfuh0
	 uZE+kw2F6JFTudInxrtzIxUfYzjXnyvz+Qo8qRzrMHSkoDmB7wpnwPTPq/cds2P+hgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSZB30aS;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1115606A320
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1115606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSZB30aS
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so2916245c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271123; x=1793875923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iymo6yWih1u6JSkjazwtYJq1W+j31tigL1sbJo3i2bo=;
        b=TSZB30aSZew/Y5iJpxyPAdCHSaUlGuRX0vGPWMGscUtyNdl4Gfru7VebT+uqAfmp6z
         QuRNmBliNwyit8/AV+JZGMrzS05uBUZyaJBYwcrM6V4CAEnFVG1H07Yh8XF6guXXqq/R
         0K6G6cvVOv6UxRt55KGii+YttWs6XbRYn3Y8tJ0JSK/FGkHwvCu2ElRB76I+w9muGUO+
         ehdbGY7CFuQhqr3Ct5KWUxe2bQqDJtvarrPkhglzBJlDKwFze5DOofXjDSx9NBRX5hSL
         ja5G7My3fhuw5URGr6Ba/QVGC9gd8w3GL/SZKX1gX5+fgnfevpEj7+FyT+7DRLu+RlLX
         hbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271123; x=1793875923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iymo6yWih1u6JSkjazwtYJq1W+j31tigL1sbJo3i2bo=;
        b=a+oo1FZwzuzZr4zHcm+yH3Sao7KUZdNVvd1Cqh9PdzlEG8WO5HxcFdGZImRwqNRwtI
         fY4g9xxin+4IJ5VzPxvT3JLvm/MYBVSaKBdeyvSRKhCf33auF+H642hGASY0HY2gCjCk
         ryNZU8VbbtKLCXw3KZYYAgjp4MYY8cpns96kpp92MtNSc1xvAxo8z2H2eJlOU8fGJKow
         BuEEUliM95+HsXSym1SpXL1+vaPbRYpoqD0EhBIrBUh5m1TB5YI384dmq9u9dKosvfwK
         NsamXxrMVfhubTx13aLIrQlG98q9wv2fQwujecm0PexWIf/uVCIpQRl60PkLNMuH1A+P
         ++cw==
X-Forwarded-Encrypted: i=1; AKwUvBzsvCH9hwVztJV99NKn8tl88dJuK5VCzOWcdBqTqvxiks/wjbpSdCFZbxEEFztzsRgg7oqEVmI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgPwongBHcrb+Ea0pM/fI+C4LoQvpq4SJX8zKVtbi8POgGLI3a
	Q95lk4WfT6nMnRvUcEO3m40g5iSIhDfAx+7i1ZlhhMukXNVPz9M03jKz
X-Gm-Gg: AYBFou10CJs4/g6i1D1i42al1CsvAMipDN8v9+uIItE6BgG3muhkKqjQ/dmw8iPutcF
	F/yFXE4EhAgXDQT0ZBh/19oGbK1tqATE7yeE0CebJHa/aiXoB/hAt4ynPAY2cKPm1ohmDHi4xkg
	6EeLubMullOcnpADRRJejG2zZVfYO+5YOSUacPwF43H9lsIM9ZhM5UiGYPMaHlCDEUtyooUfVEt
	rga+H/Il5EhK0Tw2GTobpwP4yOqo6lasZJi5Rjm2wwIwcebrk12nJLfoRY5vC1p843OaOX2I2mr
	ms7KESV9mhPfqF0uKu48enqXtWdK/OaHAAh96xChRz6OSJ+8XjyH8e36K2fNOaf4DZvEKF3aYXq
	zD+p53D6z8Jt+Eps/6OWRV0o4823Inmn44sN5O9R0jjNXXHoYjLvHEmhY6xr7+0W8i6/c+tGoef
	KCsI34juCjxjf87WbuJPn+rq83TkL1k0jzT0wkSFmFaSQJd5Jye6ZTYGuZ3FXKcIuPGD4wn1Qje
	MvjZc615enmRpSupSoBiyGnYBmRkUkAILMlGTUs3t3n/G8D7RopIB45zi+g5QE/SK3OBsRO23Go
	TMx1hLGVma8gItri67Mgl4C7aDYeXLoJrUs+7Xxj6cj8
X-Received: by 2002:a05:7023:c081:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-1a6cfb045camr6418261c88.33.1793271122885;
        Thu, 29 Oct 2026 03:52:02 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c9fd2b4sm14692245c88.6.2026.10.29.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:52:01 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	effeffe99@gmail.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Thu, 29 Oct 2026 19:51:57 +0900
Message-ID: <20261029105157.2553-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <at9mFUv1flg-6aMB@debian>
References: <20261022163116.1042-1-26rote@gmail.com> <at9mFUv1flg-6aMB@debian>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026 at 08:11:56PM +0530, Manivannan Sadhasivam wrote:
> > +	if (cb->type == QRTR_TYPE_HELLO) {
> > +		/* Pairs with smp_load_acquire() in qrtr_hello_work() */
> > +		smp_store_release(&node->hello_rcvd, true);
>
> smp_store_{release/acquire}() accessors are only needed if there is an ordering
> requirement. But I don't see that exist with this 'hello_rcvd' bool flag.
> Wouldn't {READ/WRITE}_ONCE() suffice?

The flag is ordered against node->nid. qrtr_endpoint_post() assigns the
node id with qrtr_node_assign() before it sets hello_rcvd, and the
replay reads node->nid after it sees the flag. For an endpoint
registered with QRTR_EP_NID_AUTO, the id is only assigned when the first
packet from the remote arrives. With READ_ONCE()/WRITE_ONCE() the replay
could see the flag and still read QRTR_EP_NID_AUTO, which has the same
value as QRTR_NODE_BCAST, and the name service would then send its
announcements to every node.

The flag cannot be set under ep_lock instead, as qrtr_endpoint_post()
can be called in atomic context.

> > +		to.sq_node = READ_ONCE(node->nid);
>
> There is no READ_ONCE() in the earlier read. So please justify why you added it.

node->nid is read again here because the earlier read can come before
the remote's first packet and still be QRTR_EP_NID_AUTO. That is fine
for our HELLO, as qrtr_node_enqueue() takes the destination of a control
packet from node->nid itself, but the replay needs the assigned id.

The READ_ONCE() is there because qrtr_node_assign() writes node->nid
with WRITE_ONCE() and the other lockless readers, qrtr_node_enqueue()
and qrtr_bcast_enqueue(), use READ_ONCE(). After the acquire the id no
longer changes, so a plain read would also be correct. I kept it in v3
to match the other readers, but I can drop it if you prefer.

> > +		qrtr_local_enqueue(NULL, skb, QRTR_TYPE_HELLO, &to, &from);
>
> What happens to the return value?

It was ignored, and a failed replay was lost for good, as the Sashiko
review of v2 also points out. In v3 the replay is retried 100 ms later
if the allocation or qrtr_local_enqueue() fails, without sending our
HELLO again, and it is queued under ep_lock only while the endpoint is
still registered:

https://lore.kernel.org/all/20261029105142.2503-1-26rote@gmail.com/

Thanks,
Joonhoe Kim
