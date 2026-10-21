Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594760;
	b=fH7qTpxO2j3Vv6LjcbFWfuiwMgPXbtSvniUqph6/kM0Q95t4+6fTikFqPkZFGaMpDGbD
	 U5PTvnNnXg8hRatpF8cnyPBqBTTS3lPpKLqyqAgt1Y0lr7DD+S1ltG9r9V5VqEPIwSO+F
	 M1Bh459Dbc3ZcNwM31DUQv6rZ1ZvEk60LYdzWmOk0/gEJlygkj5wS8R8lh893PTE6cQzP
	 mecMIs991vw3ICSQK0DTPKftpdplshPLDK2RenrWFtL4RX4Z8uEZfx0WcEc46dmTDDn21
	 Ly5K93GFCVXtsrD9/82X1JmEui75gU5e3Dv0rBcC3EZKmjnofx3FCS5l111m2Ougd1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=hObvmucUS6t1rWR1L9u3AvYVQ+Nq1snLbT3mu1kE8f8=;
	b=4YpDjLrN++qfa8nwB87JfF8Hyomk23VgYRwZBqSeULKOJYOaByWsf6mOsAK4YC0uF8W3
	 VRZbRfG4wvG2u2ATBT4Ygdt2gyHCGuq87j3UOJuKkOKOkZFa1ZnqmBOPSPS8j/Rx63+pn
	 AJA0wnJjdrFE1zLDbs3la7ymqWlCMJHJtiTPcVyAA9heYhRL7gk01sRqKZDGOq0OGF6sX
	 ZlI+hesioljZAEBdehr3D36ufMggn+wXz5XV0s/FmWshXY0OnnunlpT4ZOhRpmJ/39ddI
	 Pw0VhPnNxXUj70NXjIRs8TbDVgtzjYVBCKKAnDXxEz3XWfmnc3ai+h61+aFnOoGQFAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WO9+EzJK;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1F606A32A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C1F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WO9+EzJK
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfa2fdcfaeso645449e87.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792594758; x=1793199558; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hObvmucUS6t1rWR1L9u3AvYVQ+Nq1snLbT3mu1kE8f8=;
        b=WO9+EzJKvDZCAa4i5HUJlbg7DqPjyFHR5FavlN/kFq2BTKdu4v3gy6HlWq9kDt/vnd
         z4Zq7rZBRF75tNqrVEnK+W+VsEjahiudmwOkz6xukmkjENYYIF3q5UJkG2TBsIeg4Ppj
         qHrsk102jqTowe8j/4IwuJraQEFLzymsvR7k5v3xdgkk0wr99EreFczLMgXXFwE2PvX/
         RtEnsVVhev7EUxg+dOyvq54UZ9qIEJmP+nPM9zr63JQ9oSgxFXDMormbGbSdwHhwHwoc
         NaebjomKS4GyMem9+GbsBBTGVE5CSDtf/w/M3BSBPxhCPMnhO8s6arY959PR/M8oVxMa
         YSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792594758; x=1793199558;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hObvmucUS6t1rWR1L9u3AvYVQ+Nq1snLbT3mu1kE8f8=;
        b=e4T7ze/CP4pNDfk3BO72FKLzNXTjQ88AF4Z2VdnoWvkQXMY9HkcM4j0qWQ+7sbFGqo
         SMlFBHAGcFEE6RS4ZDPbrhLj8+Q/ZPHyLi3oozZ7lHtn94vaiUpfI5422w3rr8+2g97I
         4oIQ6wG4q79LJWZk+bejwt8jyeoUCioMN9h52XNCv0PR5UTtTS5oXJoBYJiMUdQs2sEj
         JzN9gFpjWkgh1J05CQshMsWGmZ+N3TpVXs56e3ZMtMVRElhgomfO+RfWfF9ImgvCwOO4
         RkMjkVzSTlF8xxz9QXmPpLD5kaEX0IJvSEU9OszrHAjGJlhyfLAU+QCE/rNgPZe/XwUl
         kYlw==
X-Forwarded-Encrypted: i=1; AKwUvBxt/M0nbQEua/Hyjing1SkZKYM5o2N9bMNIENXl+SQWU3QzFw5JXXYqu2bjc5Hvixr1/O0y8Qw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4QFs6MihIEit7vlyUK2rC88TZLXjOvdPD5s0jeuIlNFaPUlXa
	ah3/EUtzdKMpcpViUgkOFDJZmpywgbmyfnMuI1l9R1XXX6eUz5KIo4LG
X-Gm-Gg: AYBFou3t4s8UXWigmWj732hpkdgIQ9HZa5bN0qOzvjYih1cgXWIZEd1Hy3mVIHNpunf
	tr7YwjDakZlnvS/htRy53JJXoYQ//Jl2UF+3Sk9h4QvtmPNnbqnenOurZA0AfGdQ5AI/4ug7JNR
	R6d+FfHyPblikK1Js7/rkY7kdKCTsyYM4Li4P/crYaz/5/xmEzxMMpeZgBhRGpFZ33n5Io8nagj
	fWUOBv0tKKFN2GLUF5xhR3ClE29FpNPQQB6Ek3Kv/AGSbKYgE4o2BBZSxlVVkGBl95Ba/3N195K
	LG9C6kEwnMD3smBxvolxnaeJDiNcEpFCDErXhJKXBqjuLYJNU0JwPCW1fVzHxqB0Rs2Soab+KBM
	0h7FTzokswydyqH2B+e2FHi222dat4BzYwG+LZGyBlMyNo6etp2TGX8ni2K0qTrmnHHjEW9zaha
	8GFVtNxRKBIZhnzIe8YeM8VoBGeYY0/WlRn/CM+gTk44jmeHIUriua9gcRNrDNBdPDTwC7W+7PA
	zG/75SSGPOX5Fw/JQbG0FPQFnQcTceDa3tNbhA9zz4XyNtIAyCz3guHLmw4TPgZKvq/0FymKnWI
	q5yCjWTNeJGDC91F
X-Received: by 2002:a05:6512:65c9:10b0:5bf:a34f:b94d with SMTP id 2adb3069b0e04-5bfa34fb967mr478168e87.9.1792594758106;
        Wed, 21 Oct 2026 07:59:18 -0700 (PDT)
Received: from [127.0.1.1] ([85.249.168.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa4b90999sm128327e87.68.2026.10.21.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:59:17 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Fil Dunsky <filipp.dunsky@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: dma: run threaded NAPI kthreads with
 SCHED_FIFO low priority
In-Reply-To: <20261020-b4-mt76-napi-fifo-v1-1-ac8a24e2062a@gmail.com>
References: <20261020-b4-mt76-napi-fifo-v1-1-ac8a24e2062a@gmail.com>
Date: Wed, 21 Oct 2026 17:25:53 +0300
Message-ID: <179259275334.35963.15413466304986880275@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Adding netdev to Cc, as suggested on the GitHub mirror of this patch [1],
since it touches the scheduling policy of threaded NAPI kthreads.

For context on why this is done in the driver rather than left to the
admin (chrt / sysfs): mt76 already does exactly this for its other
rx/status and tx workers (sched_set_fifo_low() for the usb and sdio
workers and for the tx worker), so the dma napi kthreads were the only
mt76 rx path left at SCHED_OTHER. A userspace chrt also has to race
the creation of the napi threads at boot and module reload.

Numbers from the setup in the commit message (MT7621 + MT7612E as 5 GHz
client, 3 runs x 5 min each, ~200-280 Mbit/s rx with userspace load):

  stock:                  ~500 full-ring events / 5 min, watchdog
                          resets and MCU timeouts, occasional hard hang
  this patch:             0 resets in 3 runs, rx 276-288 Mbit/s
  stock + chrt -f 1:      0 resets in 3 runs, rx 249-273 Mbit/s
  napi_threaded=0:        0 resets
  rx ring 1024 (stock):   800-1300 full-ring events / run, more resets

A similar restart pattern is reported on single-core MT7620 at much
lower rates [2], which fits CPU contention rather than throughput as the
trigger.

[1] https://github.com/openwrt/mt76/pull/1164
[2] https://github.com/openwrt/mt76/issues/457

Thanks,
Fil

