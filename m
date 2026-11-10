Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322840;
	b=IS1n+xaUNCs5AEczYjJ5a1X7wBkHoD3jUp++I7qGa1QQiteBCB0abdrUAbtx4hkJCpN8
	 re6dm0Qzjui6rGH5OFqA1OrOzg0sKGkd/5Qhl1N49o/7gLcJeQ19zB59FQKLQYuKddZEi
	 CA9/5/6Jrj/oBelT+mvdO6M6s1OMTc9d52sHDGRJz/nTItruzTp5qA2A4FZIj33pLPzkL
	 Q35YAHDzwD/T1JzuFVUsBMFEc3Y3u9PA+8s/hI1gB89aVj3GSAxu0juSk0CNgcpG2PLzf
	 cbRGWc1zpxVymES+mtSC2QcjDshr0TQNSxEGtGrcF3vTW0hMCwQLTP4uk9KTczHrtgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322840;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YzZIHnwUb49OQ5Ge1hfLtzEhOshkFMXkInmhEVBjARo=;
	b=clPsnHhnk5NGfg6/zyWaIgiSgu4ka+fgyRYGnczDeKxnLgQBWkQsQD8D8F1DhhRE/xw1
	 VHIgsp8bUrxpmV9saFnhc2pIZ9kOVn/JBs0iK8fuzSSYY/daYAqwvIfique1Yqz6HLVGa
	 Msp9H4bIcc4un+2e4rPflf/La2EG34659OaSJFgYpezY/zmQLLulnaxvG1H8ye0TkfCNN
	 aKSxlpylgKinD0T7wcraxR8fH0Atiy8O27KL4RO5CuXSEoEuD6TVkSuFRza0cwt2KTMsP
	 pGkRx2dKq8UeTwsji5KSSljwC+zmGv3DCQnPQj1ffVGoTswGKpIoaeygD+GuZvYGMIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MfdoL13q;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tusOz9pK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441060A3833
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D441060A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MfdoL13q;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tusOz9pK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794322839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZIHnwUb49OQ5Ge1hfLtzEhOshkFMXkInmhEVBjARo=;
	b=MfdoL13qnJpwAOPM+VX1aIgHVtQX8tMsM13vlgFACgTpalPBSipGBXvyg3YphRuN+PpEDi
	1zZll86EpUoLCFlkilI51POhyMVcT6pv3Rv3sjCtPB/K77cKwBcyERPAmslZO8Mgxegg0F
	PomHURbmpEmygl9P5EPqfM9SbcQSQbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-HivhaiCXOzSd2hrvGTxfzg-1; Tue, 10 Nov 2026 10:00:36 -0500
X-MC-Unique: HivhaiCXOzSd2hrvGTxfzg-1
X-Mimecast-MFC-AGG-ID: HivhaiCXOzSd2hrvGTxfzg_1794322835
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so21653145e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794322835; x=1794927635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzZIHnwUb49OQ5Ge1hfLtzEhOshkFMXkInmhEVBjARo=;
        b=tusOz9pK2ic6QyHtNsIwAaalvgbrOb/B1eGmJzxXoiJmJf6dDJCGS1OUG6pfXHX92Y
         FhKNbyYh106vbiIJ3/1TUPtFAL82MkXSmzhDy2aXSjfrIIc6D62s5+6ArVkrHJJiqJb7
         UplRoxnkE+ebe9N9+9XDYXLpm1oOUhKAyqe6uvSiBNpzmpF44ereoOr+sZZn5qcA9wJL
         IbVv8FmK+XZ+ntUE93Bbi/0PiJRTA3xiWRy88sxLQpwXLx4xZaz0ZE1TCDvjeecJ761S
         EVha7EUO02k2gLMEcepy7RzQum3wDjgDlph6Pzv4quqEGAKuHlAsQn/evjCS5FywUX/2
         y2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322835; x=1794927635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzZIHnwUb49OQ5Ge1hfLtzEhOshkFMXkInmhEVBjARo=;
        b=zR0CGguj9kXnzLNZEcHxXQ2noFYGYg2bPH5Gm+RssEKzFjp1vrtvjsqC+nE9UD9byI
         U5/nVDE8g7POolx6JnGzFDcvqNLeFdFqYO0+ioP17fbyG0UT3kwE5KRnAXi+Nm5ywOyz
         X0H11Hwkg2WrMP0SlWU4EnM+hEZZXjSpVpAP1m9a9K/FTZzXbpnM1HepjLavOf3wfIZf
         MqB/LYc6YNajNzWVCSqpFFpG3LwfL0AQkpSXITas5jIw+Kubr3GwJwSWPfjG0talKzrE
         eMw5iZLAUhaM8RHFgraTpLhBS7+YSpDLW+rKF2SsT96MpGTlrEMucyUJwmAYcynEw0qL
         8aSg==
X-Forwarded-Encrypted: i=1; AL+hErHe3Opo2G00vYbZLi4pWvBxLRj6cd0lWQjPUOZ+WBX/HMNAhhlWgRsQE6HljsRVaJb9dpaeSBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OlT9SmzeJPTN2kfo5RGygiu5/u+obibM9uARPQBqwgARHZKCz
	ixQxjsjzRQSbY4/Rrr97WM8a/p4cvX5CGp7eEY39jC4j/PtwdOe0hF7vIPPP4uq9xmKqApV9bJl
	sXL6GZhLssPhZkKCQkOiCqxksOqzik91yhtqEZT4VCGOrUeCafSEIl1PKwwH+bzGAjg==
X-Gm-Gg: AYBFou143mPUekmRs4vKatADAe9FlnK97Se2v3Mpnd6UWwkMDPZXMdEs1q9gtXDfToD
	YbO/+T2HflcNJFdUeSTezK5OXKnLekBFjmvAcqL00XY6rpGrZPsA2r9NQWulplSmLKYfG14GEZL
	51u+zOKLwZOQfUG85J6DH9DMVtn3j5apZhvfiNb7idSRAqiGFFlETyHpwcsIBgcNxbqOU2j3VM/
	1M454HL4rLmxEZHVDfuXB1NdpswqvgHn6oLlc+ZZX1Ny0+U3pXUtNwKVAZUgLImedUcH3pXg8q4
	u0OlP2VKAHNvPQB82BQULwEIvSzafi1Wa2JFKhKjyQvmEl9wvIk80orck7dCzJuhv9b/bNHO6q5
	JrCDeDWFDjz3DZmUF/f52CR/sT6haTwVr0en9cy1ytkuk67d3YP2UFhft+kpUoKAea9tvWUEOrG
	Y/i6ZxENYxeI4D36lVsa+dtpS5Z0AlAAys2bJYse6NaAMk
X-Received: by 2002:a05:600c:4e55:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4ba023050eamr52358815e9.2.1794322834860;
        Tue, 10 Nov 2026 07:00:34 -0800 (PST)
X-Received: by 2002:a05:600c:4e55:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4ba023050eamr52357655e9.2.1794322834148;
        Tue, 10 Nov 2026 07:00:34 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0237fbe5sm47374655e9.3.2026.11.10.07.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:00:32 -0800 (PST)
Message-ID: <c14fb8f4-82b5-4aac-8c64-a2dadb210e9a@redhat.com>
Date: Tue, 10 Nov 2026 16:00:30 +0100
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
Subject: Re: [PATCH net-next v28 2/3] net: phy: Add support for Template
 Control register for PMA
To: Kyle Switch <kyle.switch@motor-comm.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20261104060636.3901918-1-kyle.switch@motor-comm.com>
 <20261104060636.3901918-3-kyle.switch@motor-comm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104060636.3901918-3-kyle.switch@motor-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 07:06, Kyle Switch wrote:
> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c7..353ca13c64fc 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -63,6 +63,7 @@
>   /* Media-dependent registers. */
>   #define MDIO_PMA_10GBT_SWAPPOL	130	/* 10GBASE-T pair swap & polarity */
>   #define MDIO_PMA_10GBT_TXPWR	131	/* 10GBASE-T TX power control */
> +#define MDIO_PMA_10GBT_TESTMODE 132 /* Test mode control */
>   #define MDIO_PMA_10GBT_SNR	133	/* 10GBASE-T SNR margin, lane A.
>   					 * Lanes B-D are numbered 134-136. */
>   #define MDIO_PMA_10GBR_FSRT_CSR	147	/* 10GBASE-R fast retrain status and control */
> @@ -320,6 +321,17 @@
>   /* PMA 10GBASE-R Fast Retrain status and control register. */
>   #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>   
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */

IDK if this has possibly been discussed in previous revisions,
but uAPI should not use GENMASK(). The plain hex should be preferable.

/P> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */
> +#define MDIO_PMA_10GBT_TESTMODE_2 0x2 /* Template TestMode2 */
> +#define MDIO_PMA_10GBT_TESTMODE_3 0x3 /* Template TestMode3 */
> +#define MDIO_PMA_10GBT_TESTMODE_4 0x4 /* Template TestMode4 */
> +#define MDIO_PMA_10GBT_TESTMODE_5 0x5 /* Template TestMode5 */
> +#define MDIO_PMA_10GBT_TESTMODE_6 0x6 /* Template TestMode6 */
> +#define MDIO_PMA_10GBT_TESTMODE_7 0x7 /* Template TestMode7 */
> +
>   /* PCS 10GBASE-R/-T status register 1. */
>   #define MDIO_PCS_10GBRT_STAT1_BLKLK	0x0001	/* Block lock attained */
>   

