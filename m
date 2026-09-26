Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408983515D7
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790461096; cv=none; b=tg9Kee8hfCPpf3Z/quZ6rKvBK4rjKt35Yf3AQQPCP6+T5Kt1EX14RpRwyGTKqN7DwSqvPHU5hHuNCk323eI1n7x5PPld6lHMBAPunZNJOGK7gKpxvnYDz6u2F8gjo0zh123uO3oIU0ESQZW8MSUjjrF1IKv1nA4zGdn01BCMpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790461096; c=relaxed/simple;
	bh=bYz7lI9kjRgqFz5/nCU1yj4EWniipBajOaYadK9YXSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSsFM14vpP7E0pWP73wGSE8bgIpMWEl0go9d1gQdNHAMmiWoU+UvOPfBy7F5u1jTPcbTonUZw/Ibor710NJLf+iySObi0omsjSklYMr7qlQ5Vaxw6ubQtISAp5NKO/AJKp8tFPLHB2Kn9AkpekkxkEhJXSSikUETF2f5d3mrc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHTmCnZy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHTmCnZy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso8877395e9.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790461093; x=1791065893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYz7lI9kjRgqFz5/nCU1yj4EWniipBajOaYadK9YXSc=;
        b=mHTmCnZyDSV8QHVko4l9814wBlm75POYo9MwodHLUISuesQgkMmeqmCcCDYSE3eRQT
         tnKWG0HegaNh0KihEeI0qlD7+aVYn4bNIz/XP+o2AKMZK5PxIVhAkkOwDEADr/efkjgX
         +NZ9R3OgqI0bq1Z2dW1175urMqAvpX8JUXt8zbahA8MBuVMv5DoHlaFJaP//r5AX3HUT
         92PhqLGY8PfGlGlUNmbqGt0AgBpZg/Q84KD14xg3XE+kzU+FGKYH3IrxTyM9OOIflhb6
         gE3y/0WV9inW18wil1SkTrP31N6Q9AuQCgVxciik9ncltdgvXRaXJuQwE8J4L93Ox/sT
         flag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790461093; x=1791065893;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYz7lI9kjRgqFz5/nCU1yj4EWniipBajOaYadK9YXSc=;
        b=QOGRpVoCIUTMeD4vz2IFmhe8zXhjOYfKd/S/bf8eg8WqrcLPLD9Mr6wfqnJaDS9usf
         JdFn/d5hlUDGUIyJ5dxAYqtC9U8xRydLY/w2Bv/qO6wsxWEOuEzx5yGFqjHcAPGLpRtc
         3jkvHn5I93BqcTiQrcdRztoNAkI5btO7QHu+8x763G6ridKpecznPtbblqYkICEUdsgf
         aZAHj+DH+ud86647m7RK2g0epciFloG0fYAsZvxYTHIjDvvVMA7YslP0t/C2Rfg2n4L1
         Wa81F3oeI0nUHJvFiuNlNHYgVLD4F1Ycia7ONXUWK4IDSUPqwxl5Bf3TvlSwJYRGcKSW
         LTxw==
X-Forwarded-Encrypted: i=1; AKwUvBx8Vw6tCEuHOcVrgPqnD34gQ8SVohQweRxylXhb7TegoB0oaQtIz1LCp48vsLh1kZbUy2niJZk=@vger.kernel.org
X-Gm-Message-State: AFuF++l8YcM2LqUXlYtb9ZpUjv43L19XxrWXvCLCrhxFHfXYcpsgxzdW
	JdIvpOCxOu8+wLoIbfEAS671j7kdpo7iohURiVKuCMxx9aVRpSXxqH3y
X-Gm-Gg: AYBFou1jybLmuPgHNBhB8zVT66whtX+d8JcrOqj/rgYjqU5IYE1sN/au8YhO499dYZk
	/F7oK0c9HxqW953mTO8R1/Xu3BKC8v7spJ2RgxX0pcLaHoxGV3uzuxmlETeL6kOoeHi40KAFT2v
	B5zU7V17QqHpeQQtDE88Tq0KquEkro9N85widVcsKn7wzzjr1GFMLecav/yFOVroRoYkVgV2ckQ
	RddvhfAH3dJO99tUDim3s95kcsoUxWkVwUJrFN8i/EKt4ZdI7mti0i1imbqOlkZCjcCyFBrSZ5h
	a8UVdBDroLXceRP5AycRoW6n5devau/tfEHHPb3BSDB4NISxXfDom4UpCUCQmu3B753TAphskBP
	A6BJ8GONQzesTb9Kplg3FYtGncqs7G0KkUgHaOuFSwFiw1PN6Iz956zbub5yfzmY0l3NvGErOPy
	Hn1hsF1gZf/zM3Xf19CX35oNLSklz3VancKEsvr7NgEP0MTrzMFutNnhrobqRPtHoVMU4Vc1Jas
	d35Q+4S
X-Received: by 2002:a05:600c:4e90:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-49ff06e506dmr100694585e9.18.1790461093272;
        Sat, 26 Sep 2026 15:18:13 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0016a8c2asm8941265e9.0.2026.09.26.15.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 15:18:12 -0700 (PDT)
Message-ID: <42367817-00b3-4e6e-9f16-50de4b49db64@gmail.com>
Date: Sun, 27 Sep 2026 01:18:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfrm: fix suspicious RCU usage in xfrm_nlmsg_multicast
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com
References: <aoLLSiD7yjcaH_BI@secunet.com>
 <20260818112038.56788-1-omermetekaya0@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <20260818112038.56788-1-omermetekaya0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/18/26 14:20, Ömer Mete Kaya wrote:
> v2: Added Fixes: tag pointing to the commit that introduced
> xfrm_nlmsg_multicast() and its RCU-locking contract, as requested
> by Steffen.

Hi Steffen,

Gentle ping on this v2. Please let me know if any further changes are
needed. Wanted to nudge it just in case it got missed.

Thanks,
Ömer
