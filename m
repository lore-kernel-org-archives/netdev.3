Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481433;
	b=ZLCqN0DrsnfkBO2Xa3RLxwgvRlnnaTg9DNbsHd//DFXrVi3x+4AbeBsfzIJzk2TNRiCx
	 x52f1C80iKZP8r0d7mrf2CPRVuSr3Ze/PJFlLBytLURtPmwYdo1h0WeTBTqGWDBYQjoCs
	 +64F7kQfUyE30eO20p/RSyNwF+EZwL2ybg/yWZnGo1II7Iob+TWwzNusqfWoV0GVtq5uy
	 JKsPtNe7+4D09ZTXaWVSBgIRHopgK+FKlowxxHRAbkO76kAIbQi9qAL8SC1WhoxuHw3VV
	 4FlVuXfdweGEPxky5Q2luMTOClT4BTfndBIdU2ox3cPNv/QFLYStcC22qu9VDCYYo+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=7DL6NZ+BkMPV7VqBQUXBvWcIZ0TJ2DQpusktaObjwcA=;
	b=kSyPROc4MWj4e81BtB4ywBE8kaXT0wX+jugD8/4wCDVTEcNi16HMoZRlCKrF8rTTd5AD
	 zbzL+vjmyb+nXCJdu5xJbE6ERZ1oz5v8X9RbB/OwCKEmY0Woi7llXl/KYgoAbqAt0r4IM
	 rZ0rof2jwY2H2mFmG5jFtA/JxGyLkNA4MfcQhB//dN+rJmGPS2sDA8eiiSjOlTC8BSoX3
	 HoXmEQ8DreludC2e7rMRMdZc0rCwno0RVN9r+CAIdUxVGRLrnYf3T5imDwLcbKOOPSX6e
	 q07sdxndhzxUCmdr343xkrlYB6yCgEtt2z5fEV0VcbAxz8ArgZ1W/lrfDr4JzTeRh4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bTHF5xOZ;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B75606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B75606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bTHF5xOZ
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ea5600c9cso11107236d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794481432; x=1795086232; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7DL6NZ+BkMPV7VqBQUXBvWcIZ0TJ2DQpusktaObjwcA=;
        b=bTHF5xOZC5ct22O4VSF5DGZdCzLfPtQcvnyeZBW5YGxHf4Hu9NvdPMpmXwL3e1UF43
         7sIULqSy3m5xcOCehqDMQDBgzENiQoJpHkIhlyB9xr+sdCKc47ktGru5X8g0i7SXTng/
         7fM7WSEl56hr3jeCEOAcbZ5Eds1lD9KL4Qs+5Ukw3UFYzLM1M3viUjZQiunDbrrjT2t3
         8uGN8vdiURQ111vP+2qfGvI9TTzoG9LE+OP8877Mbg/jvni1oLAVVZ6SfJ10LkMALIuM
         nn3ZGR4T3iOSyOa2qq9UN2UIvj1TORTEZpO6s0gnn7ZcgF8Zg6XcvDyC0njkUJcJehlV
         Frow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481432; x=1795086232;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7DL6NZ+BkMPV7VqBQUXBvWcIZ0TJ2DQpusktaObjwcA=;
        b=q8FfUqPFv6eobM7gXlnkGxNfOcmcnup9GIzq7l0zITCFpeQrcal/6ioZTt2UmzZUvG
         8KC5ebvUh0QHVaVwnQxsJ5q+tA1xizeQed0i8EQ0+dvS1lh2OeO8gkZgS3cofXDLdkEi
         9HOk3AcfNil7nYYvJAK/9hveU1jH2bg/6Btn0WB2FE+4K8y1BOgauclUt5/Lmfr1zM/S
         CeLCUCNhtCwUb2ELdBsA4L8xgjG45JD9PK8WsP6w4e5ndoepIWw6DmjPBcSNP4WLNW5h
         aDNDoKIlynHK6FNU3b1lb8TXQAzyQnxc4uHkvtAkt0mFakCLqMRwGfLJtxaFerIh6b+P
         4AJA==
X-Forwarded-Encrypted: i=1; AL+hErHAMd6HU4z24vJESDl+RO2IUfQGdbYnD8sadW89urPVGXJM9N4hJjTFwi/gpWuGrtwb1t4C+Dc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hD6Fb0Lwq+Gn2G7Wc2/0nb2Do4ENUN+Pw994UhxAY/2USBF9m
	yu9jAaUqRPr7XksWzy77Yhz0nouR8xdPPAdscDUYIGY7F+AnXo6AkiCH
X-Gm-Gg: AYBFou08tT7AQQgzXxil17ohc85eZrG9nlZjg7FXSsHSPIQcqBHHY29q3fMjEfmiR1z
	alx2Gwh9OChz3/MvOLM0PGo321jISzAOLmmHJGAsl/AjICgDnskGYAK3ajO2Kz2UXwO2TLuDbsy
	gRkh8IQAHVdOh55kF4kBPJ8m+41gUPYbwbQBAFdvsdHD+y4iqU0jCevWQHKwRuWoS5M+aOWO4Vm
	xJ8wRn2cuCzZCYFtJ0cXVgVmGdK63NW3SwQh5u3hT7in4x6jf1zcSvszDww/p8YeuNyhLho/cro
	zRCtyEZGBJpwqL9Ty6/hmlvnMNEFly1/wqecDh7seFiXvUtA1iEpsH2yLAFDYDi+ZNZs7Ej2C/i
	bXICUfmh1MuEzaR1qvqNZ+lOFInYLj5R8PZbTL14lD9MB8oH/TUgLo47D0wi/ZKv8Ra8nZtrgq7
	uAbdVp0l+y0qY4lmtpNMdoPv44kQh4Yj697x4EEWr3sGo5Q/YJFlVcKD9VElUG2Np3Im0fl1kfq
	CJERwtZRV0DHLhb9z5uUK06mvnsM34Mbr5EPh8IKUTLJer0nvtn2DsdSVO2rqmnt0AzU/w3bey0
	Agz7CHJBdB8kdhCPZy6B+JUH3YbXnAuTQQs=
X-Received: by 2002:a05:6214:5291:b0:91f:1bd3:d98a with SMTP id 6a1803df08f44-91f1bd3f546mr9764396d6.6.1794481432126;
        Thu, 12 Nov 2026 03:03:52 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f20176493sm1379066d6.5.2026.11.12.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:03:51 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 06:03:50 -0500
Message-Id: <DMT6KSM217ED.NPICK8VGAPQ0@gmail.com>
Subject: Re: [PATCH net-next v2 4/6] eth: mpnic: UDP segmentation offload
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <dimitri.daskalakis1@gmail.com>,
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261110-mpnic-lso-v2-4-ccd37b051d08@gmail.com>
 <179447813712.2199510.12165491734923049464@kernel.org>
In-Reply-To: <179447813712.2199510.12165491734923049464@kernel.org>

On Thu Nov 12, 2026 at 5:08 AM EST, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] This patch adds `skb->len < MPNIC_MIN_FRAME_LEN ||` to the
>   generic `skb_is_gso(skb)` branch of mpnic_features_check()=E2=80=A6
>
> --
>
> eth: mpnic: UDP segmentation offload
>
> This commit adds NETIF_F_GSO_UDP_L4 support for non-encapsulated udp4
> and udp6 packets. As for TCP, the UDP checksum is seeded with a zero
> length. It also makes mpnic_features_check() fall back to software GSO
> for skbs shorter than MPNIC_MIN_FRAME_LEN.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index b78f8599bbe8f..2a0560b7dd19e 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> @@ -369,7 +384,8 @@ netdev_features_t mpnic_features_check(struct sk_buf=
f *skb,
>>  		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>> =20
>>  	if (skb_is_gso(skb) &&
>> -	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
>> +	    (skb->len < MPNIC_MIN_FRAME_LEN ||
>> +	     !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size)))
>>  		return features & ~NETIF_F_GSO_MASK;
>
> [Severity: Medium]
> This check applies to every GSO type. That means TCP GSO skbs shorter
> than 60 bytes now fall back to software GSO too, not just UDP ones.
>
> The commit message body only talks about UDP. The only mention of this
> check is the v2 changelog below the "---", and that text is dropped when
> the patch is applied:
>
>   v2:
>   - fall back to SW GSO for skbs shorter than MPNIC_MIN_FRAME_LEN, since
>     HW LSO would segment the zero padding as payload
>
> Should the commit message describe the effect on TCP? Or should the
> check move into the earlier "eth: mpnic: TCP segmentation offload"
> patch?
>
> With only the TSO patch applied, TCP seems to have the same problem. In
> that version, mpnic_features_check() rejected GSO only when gso_size
> didn't fit MPNIC_TWD_MSS. So a short TCP GSO skb reaches
> mpnic_xmit_frame_ring() with HW TSO enabled, and gets padded first:
>
> drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:mpnic_xmit_frame_ring() {
>     ...
> 	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
> 		goto err_drop;
>     ...
> }
>
> Then mpnic_tx_lso() seeds the TCP pseudo-checksum from the padded
> length:
>
> 	payload_len =3D cpu_to_be16(skb->len - skb_checksum_start_offset(skb));
> 	csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);
>
> Locally generated TCP GSO skbs are always longer than 60 bytes. A GSO
> skb built from a virtio_net_hdr can be shorter, though. Sources include
> tun/vhost and packet sockets with a vnet header. Such an skb can carry
> a tiny gso_size and only a few bytes of payload.
>

Local sashiko review surfaced the same complaint and wanted me to pull
the check forward one commit. I decided against it. The UDP case is
easily reachable because the user chooses the gso size. I don't think
producing a TSO skb shorter than 60B is really possible. The
virtio_net_hdr cases should have a min GSO size of TCP_MIN_GSO_SIZE set
in virtio_net_hdr_to_skb().

> In that case, wouldn't the receiver get the zero padding as TCP stream
> data, with a valid checksum?
>
> The check is still present at the end of the series, so the final tree
> is fine. The TSO commit on its own would still corrupt data if someone
> bisects to it or backports it alone.

