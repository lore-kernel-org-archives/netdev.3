Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380721;
	b=kwfOuchL+Tkv3CV3MwVhpPhPd1sTVjQyXMpIHfKBllSSf2ihFUkDwkUNoSV/5sbd0yB1
	 6RXUskOKf0U/wuSx/V9BlncQ+GNG4Uzvw0hn3WSu9sThOovbtPUHIz3oIib73TBQzkD+E
	 qQxcl6TdwS3fl3aUsAdcTElLskca+x0V7xPul8LdeZ2iZDbBVRWnYVpg7PkShMBRXIR78
	 7x2FpaoJPq0VTX+F+1BLq+hDvxIyx2koRTqQiJEHeyVfBl7U11T5UQZZy4g1dUrhku28P
	 VkdF6ZD5lT5ZECroen+VJ5+geLP8Wpkb0BzwEw7AZQe6dI1otlnlRlptrULWZTw2uBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=P1uqo7C/JrGtMIVNU/yYgKX0OwbZ0XFibLQffeq3In8=;
	b=1HxQLLCOH9FLktrRdzMcbUkF/uIV+HYuldSe4IzVr3S+UMlACSwHjhb4gZ0KTmFyuv0F
	 RBXYhZn+XiOWBLZl23u6Ahp06xNDmxdlhnRrUke9hzTHCcdh3bUJNfd9OKyeLmrc1Ji4L
	 OhKhJ00vM6UTuAIYfUrULZVVyf5pypX/GQBnIBoHQBz+RYOm4kVzJ8CBSUbzqUdvuya1D
	 yrwTdmRz9Svb4zVK6IMURyyIf2vvvIOe+G/XYSooS9ZHev85Bz4A3L02OHVzTNg+HSNwe
	 QShZC71lqis48VW7v+j7ZbyggAVXR7MxmEkZwk1gYefbLQQCe90sieW6Rk6OGc/ZfGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ij27kj3r;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F4606A320
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9F4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ij27kj3r
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so1151127a12.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380719; x=1793985519; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1uqo7C/JrGtMIVNU/yYgKX0OwbZ0XFibLQffeq3In8=;
        b=Ij27kj3rh7jDkNne4YmRr09xPVJSWqvJL4NGnEalvehb71QAzoX8wEXHxvuo9/2xm7
         aqoT7d+vLeunRxOxYniOCOGso1HtJXGiMMujjJ+cmW6jUHQbtdKVMdlqCLiAwCaRxAls
         QZDGC9c/wj6FnYWGdmPh2iHTsb4cgWqiTZ8PYHenUiO4O/CL0WQCeuZD+STR5xFmAUcC
         9+armJyqi7yQL1EUxe0onoGIYAoMCXp+A+onBxpxnBaR4zM+OAoeQ0tw1wsNeyts7HQT
         LLFFfg0uoxFW7/DM3Kr9BqgsP1mTCu8gSztVxps+LmpVJwCTobgBHWPHmaEfxSB3P4Jx
         ZEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380719; x=1793985519;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1uqo7C/JrGtMIVNU/yYgKX0OwbZ0XFibLQffeq3In8=;
        b=juHk+odLoJ3UUHSTPuRvY+Tasn+vsZkQcJyCCfjPmFh6YHiu4dFGvlbAUNuNLl2mkJ
         GRGy3Y8HKwKQ/SGdck9B/3Ot6/EjtpPlfZtvOIWhQ+tx8iHgXQlqwx5Ad57qOSJgLrS8
         uRmC2R7RN+SCiBZAok14doU3wuZXNSESmGENnPtFr55zGqMEnb9NMzH2NaRrVh2wXFpu
         CgP/5EzTSgPCGdGZg7PdzO/hIZnTCltaEa89B4ptwd9yrnJAi+2QdxHURsEkfLbmHQel
         y61nyNfqnOWGnQ/qLbkCqqHnIUnyxgO+oA6yWDVmLfMVTGHQceOffooYBxaxZe45CBZk
         dfnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvhAlfOLHFNU1Y14rRgxrIkCjymBBo4qDiLijbk4XLysf1gf1toLZ7hztQQLEmXueeXp50oOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLM5390HtsLkF2aaq1bouWQWVuWybA5m+UadFWt5Tqwjypn53oh
	QXwmw425qYc+sm/sciY60hHmxJLrShk5bfy2z3UJOcRdnLrspF89YyRPPNSEmYu3
X-Gm-Gg: AYBFou3I5TeS8OEa0LEYgxrZuLDPSEb65TCyOzuq+xr5xxuT4T0WPoM4m8Topo+eRwM
	B7ufQjvgicgk2OpfwbvLP9bQBw/709FB2ii51W2xgbfQHXbkHgA5xOzTA3X5d6iQ4P51WDZFpvv
	cRYxxnmCSqMcIuJbJ/NvOlDwXHnCHQcMok1XWt7zeRYvZy0HQQfZwS18lpI0t30pyjeF2Zz6xj7
	3LPAW9AL1CVGH5bkkunN601kU1jg2dSoZjv5+Q3vjn73Fg/osA/KUwrHbzIT508OX7l5fQBL8PN
	OSzH9INGN8UeDXe0ekK6R8a6wRVXsNe+35ndMaRkhHr5jD7W6vozUPdwm+lyZ1XhxBScgZFV/Wf
	0vCty4Nw9f5Z9QPJrDK+xoB+I94arqPp6JQVx3/dSYZdQJS9GeqwE4X+hxEUGGHql+9RmCJpqI+
	SVQlDj1pSM/48QXpnueUBKBpGUFXI3ieoglYxQx07p8iUQ3iCN6vYT2gqT3GIn1WwbDDyQykqDL
	a1UEAsd2UU9JL+N4kYuBPr+s6pqBdJNAJXqXzVdC8RDl0UgktTsothXfdfgxDCWw6zZkW1ab6i+
	96D0gHYE8NkrDLcSAAKTdbaeH1IW0afFrK2M2AnLL6fAWngjIWawmVtH8nu/Qqcwtg==
X-Received: by 2002:a05:6402:1654:b0:6b4:7c1:ce3c with SMTP id 4fb4d7f45d1cf-6b4d44803c7mr1595508a12.8.1793380719230;
        Fri, 30 Oct 2026 10:18:39 -0700 (PDT)
Received: from localhost ([2603:5004:a0:200::3516])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca214fdsm177695a12.36.2026.10.30.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:18:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:18:36 +0100
From: Jerome Tollet <jerome.tollet@gmail.com>
To: Marcin Knap <marcin.knap@vecima.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject:
 Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is full
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Message-ID: <179338069669.22800.12175576942287801197@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Marcin,

I tested this patch on a ConnectX-5 (firmware 16.26.1040) with
AF_XDP zero-copy. Both test kernels include my earlier mlx5e fixes,
e01620844c5c and 63811edf5125. The only source difference between
them is this v2 patch.

The receiver deliberately stopped consuming the RX ring for two
seconds while continuing to supply FQ buffers. Each run recorded
roughly 1.8–2.6 million RX-ring-full events.

With striding RQ enabled, the kernel without this patch reported
225 RX frame ownership errors immediately after consumption resumed.
I reproduced this with need_wakeup both enabled and disabled. With
this patch, both runs completed 15 seconds and received over
15 million packets without an ownership error.

With cyclic RQ, neither kernel reported an ownership error under
the same test. This is consistent with my earlier cyclic reproducer,
which was fixed by the mlx5e change alone.

So this test shows a remaining striding-RQ failure despite both mlx5e
fixes, and confirms that this patch resolves it on my CX5.

Thanks,
Jerome
