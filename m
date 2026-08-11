Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DE28033B
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429549; cv=pass; b=hKHPi4IK1zpdnvhk8l5bDMjWqokFkgyH4DGEIO8EfCJimgeDYpZ/XpFO9UpRmh/tFT+TqWnzBxYIPaauWdKI1FDuN+ZQVsibncc24viFP3lA21sWLnLdApVScLaZC66u9uoenrdBn+bduKtOjggAjNcl+IAPt7tDUQf/oZlVPh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429549; c=relaxed/simple;
	bh=HziUGndMFc7MeGEGxQSs3QF2dGCZTWUIYcZUxwwzZd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVKs/y5dDnFz2YaVWlDS3TCjqpLDZaBD5BwrIKJVrWz9iKBKKXHYnd3Z1AHth4eYvpnFH5wYl9yhHT3enTnyjXiEffGoId2pTI1ASKp/yb7wwrMJmKqQI8a4N5o+L8jUg09MD/bENEy/eBxIGYuIuedWcy/U7xcL8CSwhgrWZBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIs52udA; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIs52udA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d01663d816so23675205ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786429548; cv=none;
        d=google.com; s=arc-20260327;
        b=cyYA/aYsiISqGFle51eumbMPN2hqRv0B4Tu6iiVoXy+BF3x2kBkRgcSU+egkGgYYTU
         PXB4Q2vfqxAcWABTgKIdEmJ14Noj0T6PNCdw7F0dNhojjOG2+f2WfhHFWKj1hxOnDkMd
         o2fhU2m69EOV4MH1Sc3TyZ3Wb/EPy+zx9LHLrh3vim/N852EAjGwZxsxxlgYR54ACcK4
         FahEmFPqIl8hbAmbCnf7recr3wXqfzxb47YZMykbawH8ConSIX1fiNqlsI7VTqZwyXP9
         7HI8xojh3xArHVOP/hnBSpdjoAXJLGWyu1nc3xM8qzkCEUkkNHCXom9WpuItAeg8ELxN
         iNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=exyYoQr85+/zgEiZAlPb1xXoMLioqBIxi3VSaRreJ0g=;
        fh=tQWgGQj9w1lHSp2KQ168vev7Xr16q+OHMQPuqeDE/RA=;
        b=hMXFVr0NG0A1ecWQ8PAitKDpHBpLGVE3NGdRqO2R3/QqatvbNZ8zeekzqYnECIL5jj
         UGaACqidtKJNYAQbVuvBfHd1PF8ZCH6Isg6CbPx+8F2mrpdMGp8BeNaYVx4oP6/eH9Ev
         qXsaBuM1+kgMDjaAE9eXf8AHbKgaUuSaQFd18HjtTRJ8Bg4lF75Y9UWTR9bVq3zDpF2D
         D95kT/FtTixDp+0y/mFzP9WGt+38rVYtlPzxzRKDmSsE20N6eatJXcwluYamqWpz6CVc
         0QHGaiY/T3raBnqog50k6tBw+xCcLVqErGu9Cc05jOTUwwdK01GORNZgR6Aik1tla/9A
         inyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786429548; x=1787034348; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exyYoQr85+/zgEiZAlPb1xXoMLioqBIxi3VSaRreJ0g=;
        b=iIs52udARh9iA/3HDRlF4SYmzIK+/pk+imQmAMhQGL5JF++VfPMwYc++ioHNjFCjPy
         fU94EteftO/Wq4ff67jFtlltoGwSE56pKz4MPa9Fxq8njaocOxdKA7l45EBGmbJR6eBy
         n03dmy9Au/Je8vCGKlAce1g+vqH85ApHHjGBhSG71/ySZBp6P0p+2t2GTev/uXw8OkHH
         KVE/+xp2iR+Ebkts0I1n9i0Hep1oGJbHPVJvBdKpiLimMyEOKhbS7jo9uHdw1fADZiBZ
         ZuIO8PX/vgRPqejuFy/wXxFhK1/jPd4YWwsNY9chbQJUdT/86wI1axCMv/2YTCp6P5Zg
         I4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786429548; x=1787034348;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=exyYoQr85+/zgEiZAlPb1xXoMLioqBIxi3VSaRreJ0g=;
        b=D9pdFh5vKidOElPfSfPQyqGLA3iWNVN84uKFcfNBp5RnHbtgJnT9EzTDN+h91srsdt
         TfSi4ilIo3I2CWl+CzvpImfmieTRXU9lh6+vGntP2iEBwodEiTB92ij9hCawFBbXbDgS
         Ck/LCMx+lEWOvnHJWo9voZOyUh+Z7opmRcQn/5ZyJR8JaydWq+P6dkdMwWG9uZawZYMQ
         ULMHiAPA9kGua9kjGuavW9s3gPKlYuACHGhXHMQ+mcnBYAfJzVyWiivRO0gBPY6PT3lj
         BFUHmSNLf+8vsJDv3pIUHr/R+iuGdcv9yxlhxqUWAoqfHPLuEeZRnAiYqdAm8r7Rn3Zb
         uoLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoazWdr4uK6o7ZD0WOsBQrUT0DgkocVClCbJ/Xu8RHwu6majAqPM/CWYUzBzmNlfpVW2cTa2No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+DMXKoy3/GdgiouY2UNlze4X4PEYgsFO7yRYvPi0GALJ4SSK
	dmnVRgqCne/t44BqG2o6r/12hdJsHd7tSoWoYAywf/QxwQRZd1aQlWxa0iFv5AxsLqAp3WwSLlL
	znXb1H+1zw3MQopWBjcF/KpARVfsA6eg=
X-Gm-Gg: AR+sD110ktiGsSUoD5H9X2m2opmAsnOCLj7CjYWMqiutqxs88MfWXpeR7Rui9wXZ6Gz
	1vrRL5RFGv0QBiWqsEkz8NKob0mnxXEi02x+sdJjEomUQ8MckUCwnv/miWW+apJKmcDTIqrRGM6
	nr6v//Jkt7Se3ZvIQSrZwuMuutxeyGQcgV9NPtw2McAymlawNnHEanS0K893es9TLQysveX6ddu
	bzlWHO/ZA2pz3/QV8FsyvozweX+G75onw5o2V9UGB0I/9gETM6HjFnYzsfrTEIfulSottsFtwil
	miBm1x9gQJ6e9wvX8aG+al5aFkKdJN4FIR26cw+6NQg6sg==
X-Received: by 2002:a17:902:e784:b0:2ca:b4b9:4586 with SMTP id
 d9443c01a7336-2d3178e8ac4mr15231205ad.19.1786429547788; Mon, 10 Aug 2026
 23:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf> <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf> <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf>
In-Reply-To: <20260810120821.lykofvogbrn2y2ps@skbuf>
From: Semih Baskan <strst.gs@gmail.com>
Date: Tue, 11 Aug 2026 09:25:36 +0300
X-Gm-Features: AUfX_mye1U5Y-U80Fthekg9s2fcroq1tFZZjKcaqU2ZC2J9d4b0xoZAjUu6S5aI
Message-ID: <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> What about VLAN-unaware bridging? Can packets with VID=100 be forwarded
> autonomously between two ports of a vlan_filtering=0 bridge if that VLAN
> is not programmed to hardware?

No. On every b53 switch measured so far it cannot, and it fails in the
same place on all of them. The frame passes ingress admission (with
filtering off the driver programs VC4_NO_ING_VID_CHK and clears
VC5_DROP_VTABLE_MISS, one shared code path for every chip), then the
forwarding stage resolves the egress set from the VLAN table entry for
that VID. A VID that is not programmed resolves to an empty member set,
so there is nothing to forward to on any port.

> Does the behaviour depend on silicon capabilities, or is it the same for
> all switches handled by the b53 driver?

The port-to-port part has been the same on everything measured. What
depends on the silicon is only whether the CPU gets a copy of the miss
frame. Three chips have data across these two threads:

  - BCM53011 (bcm5301x, my RT-N18U): measured for the CPU direction.
    Every ingress-check setting (NO_ING_VID_CHK, VIO_FWD, VIO_TO_IMP,
    plus clearing the VC0 miss-drop bit) delivers 0 of 7; the frame dies
    at member-set resolution, not at admission. Whether a miss frame
    reaches the CPU at all depends on the IMP routing from the other
    subthread: with port 8 as IMP it does (indiscriminately), with the
    in-tree port 5 topology it never does for LAN-class ports.

  - BCM63268 and BCM53115: Jonas measured exactly this case there.
    Standalone RX works even on a table miss, so the CPU copy exists,
    but forwarding between ports does not. That is the case you are
    asking about, on two other generations of this silicon.

My own measurements were CPU-directed, so for bcm5301x the two-port
case is inferred from the empty member set rather than measured
directly. For your question the measured answer is Jonas's, and the
mechanism says it generalizes.

Best regards,
Semih
