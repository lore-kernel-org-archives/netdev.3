Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329705;
	b=SsRZn8s/nP6ZjMrET2WNqsr5GX4PfcO9YJA0owRGklgYmd+whqgr2oznl10vcrEcE+3B
	 aOfLyAsDmTya4NqvzAd+LCn+hz7c9XtR5OwvdAj+5P+3RI4BMCmt3W5oa971nPb0LJWvS
	 eUKlojuQzujYrZsAXQ2ESn3c/qZXwMCom107QCkg7Pf+WgzkYcSDZzeQDLLfTyFz4JIBF
	 GuZXTJrsnBC/LlATmu0IZnO/H3WRui7R18iTZ6MtTwOzxsZMcz7BioZkdjZ/IR02HgZ3W
	 RCslIEqKAyp48UOEWE291icPc5tGobcGLbMY7T2bdSGOqkNcK8Ijo3j7+y2UMTVzeiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=r/J1XL/M8NofZn4/v/wPEfCpg6OLcPmfYulknqMzvUM=;
	b=Qe8GxwtFTxj1/26+F/ApT6BVJLFoHsc08wULg/6ebfOqmPqsauhqmv8xYFbh4RQJvjRO
	 OHbZZGkEii9/tD5R3WFYdxWkEmAFORZTzOANXFZpAm3/l28WLvQAmw17bNc6Th7UtxszU
	 FctuSYKca2sgya5h9ydwZpYcR5KuHDLD+AJgaK0QA+sNiyB5bsOUZfO47FWdgnJfrwLTR
	 PNcUXBEcczDsXv+D/7LZqFczJZC2wUWXFrF0JsXIYUbzAogqx34JeoPiDLonBbuRRC6XZ
	 XHt8DXhlloZmCxyOCG6tu2gueh07JQ3dkwts9cG/YCj/VrvTog9HTMBXi793qz+Y9kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQ9MXEHj;
	arc=none smtp.remote-ip=74.125.224.135
Received: from mail-yx2-f7.google.com (mail-yx2-f7.google.com [74.125.224.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309E606D200
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8309E606D200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQ9MXEHj
Received: by mail-yx2-f7.google.com with SMTP id 956f58d0204a3-67a3d39e403so1526194d50.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329704; x=1794934504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/J1XL/M8NofZn4/v/wPEfCpg6OLcPmfYulknqMzvUM=;
        b=iQ9MXEHj99R6Za/CnMtjaRwnq8PN5Dw1EHSfCZVwssJsk4YnLOJoks79peXJeTzgPn
         R5r26EzF5+5eSXOIv3mjeK5Xya+e7y9SELgiLIrEoSbZG4m/F1DZ4TrehaJ+KtXRBtT4
         871s0OCP5Yee7408DlzCO/1xf1hLqak4jTbyEXjfh9PH6uhoTUdnfC38UaL4w0PsGaa1
         I6+b1iruk6ZRzuQsaxu5gp319ZDjneKSXTj5x6wfM7ULxuq1SD4QXhp1mBXkXd4Eg2dO
         IDZOICE7voNmZ/6vXCSJ0CU1mTZy7eAXHCYANfpLPIGdKdELQfEiATA/4g6+IX2TyHla
         ZIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329704; x=1794934504;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/J1XL/M8NofZn4/v/wPEfCpg6OLcPmfYulknqMzvUM=;
        b=f9z4oB1pszUI2Z5WwlAzS6v13g+upclNoN2ylhZ0b6WNFd85+ae+3AriuUYJBsqrZV
         OzHQiAaA59CH4ES0OSGaL2fOA3ECKuNDLulAP6OWkyyoIsDbw8LxHtb+xyC/n+63qKlS
         0eP0PDZwPf5PMs5TlHfnZSQsh/dJC1E3ED0qIAdCNbVv4MK+2/tLmGKT1ppO8MD4/v0L
         vHiPbngmhlO1Li6GpynUwZr8JnTcXzDtZQTRJJp8AR7x0ad1igpGKYayz1pbk8y2SFET
         PCAfE+qdG17GQC8/AO0aa7QTBny+8hFofJY8wwok/Wlb8WLJzRycbJZXcD6rJTsaFzkm
         muPg==
X-Forwarded-Encrypted: i=1; AL+hErGBwphlf37w3+n9T2La5tUYf7B/ifTdZWus2Y8o7Q0MRX67DnszUV9fr4uEVXitsmAaQLLS6kQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AAUBJxQ3JJfbk7UlQiINooaohuthm6nqisUQ47doIpcTHR3Rc
	ys7Z6OAEEs80JDoecHNCqZoNBFKZcuRZx+C9Uq2wjOkfhNyPU7V3ozxk
X-Gm-Gg: AYBFou1l0AIkV7/G5dVouVxxd5SRDD7GZBquCP4JNkv7s8p45XmNXsgagsGbVb/IRug
	M/yE01UMpp+x+/jHWMPCsj1hMS6vBWZDuzYCMziUt9xD5/zQX8BgPGpt0CClcej/sOGHH+hdY5R
	Q6zTESboJGo3WeNJZBe/56bKSxbfjRbbQfb/0s3PlNr0MK3c17pM79h/Av1TNcBdM2dCCge0bvP
	w8KPDvrcuBvXNTWrjVmtjaMbFOQUwb9srsTyzqm4JdfsxtFk3W/BixdlBXmFinMMU7JgJpNZmDb
	ZPFCzfBM8BfUI+lsxbq8UoU/ZcC1a7Q0TrB++4OYsi/u4otHRJODPz6/a41qCUauHDd3U83FpVl
	a3X0fOWLV3w5pMEM339bEPDK3+gbgV1x6JbEFTX7EdegdPF5p8yjAhe5TpWbeXgpMfpBTdUaddk
	ei3/yvXFaX9qUAwPWZKNk0eKHBBHVJHIEmmmqw9+UyYjiJ1nPB48B4b1GDQj7nWMCjAVtM6bayf
	d8X02dl052DxCdO9d/wu/KcL5O/6EG7di3c7C1JFBGOSFqoR8r4sGGJQ7qQHr7Ef42lXqFhTsWw
	q+Qg8BRziK6fP29aikWudWxmvWzreVizXMU=
X-Received: by 2002:a53:ed04:0:b0:679:b810:6df3 with SMTP id 956f58d0204a3-67c568c72d0mr1465408d50.84.1794329704143;
        Tue, 10 Nov 2026 08:55:04 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a2354sm2255948d50.6.2026.11.10.08.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:55:03 -0800 (PST)
Message-ID: <a24bc088-3316-40f6-a9c2-acb77fc9befd@gmail.com>
Date: Tue, 10 Nov 2026 11:55:03 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/6] tls: send a KeyUpdate at the record limit
 and on request
To: netdev-bot+sashiko@kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, hare@kernel.org, cel@kernel.org,
 kernel-tls-handshake@lists.linux.dev, alistair.francis@wdc.com,
 martin.belanger@dell.com
References: <20261105-keyupdate-rfc-v6-5-99b695f9eb4f@gmail.com>
 <179424471332.994134.12793914111732564453@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <179424471332.994134.12793914111732564453@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/26 12:18, netdev-bot+sashiko@kernel.org wrote:
> Is 2^24 the right limit for AES-128-CCM?

No. RFC 9147 section 4.5.3 and Appendix B.1 give 2^23 records for
AES-128-CCM, for the same 2^-60 target as TLS 1.3. v7 will use a limit
below 2^23 for CCM.

> Should TLS_TX and TLS_TX_TRAFFIC_SECRET take tx_lock, as
> TLS_TX_KEY_UPDATE and TLS_TX_MAX_PAYLOAD_LEN do?

This is the lock drop listed under "Not changed" since v4. A TLS_TX
setsockopt() during a sendmsg() in another thread is an application
error. Mainline has the same window: the existing rekey takes only the
socket lock, and the records of that sendmsg() can go out under two
keys. Taking tx_lock in TLS_TX would make the setsockopt() wait behind
a blocked sendmsg(), which changes mainline behavior. The design of
this path is under discussion in the thread on 0/6, so I keep it
unchanged until that is settled.

> Can setsockopt(SOL_TLS, TLS_TX_KEY_UPDATE) block indefinitely on a
> non-blocking socket?

Yes. v7 will remove TLS_TX_KEY_UPDATE (see my reply on 0/6). The
kernel will then send a KeyUpdate only from sendmsg(), with the
caller's flags.

> This isn't a bug, but two parts of this text don't seem to match the code.

In v7, the text will say "before the next Application Data record".
The TLS_TX_KEY_UPDATE text will go away with the option.
