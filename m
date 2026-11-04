Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793811109;
	b=CEojni4D8N8eMS5NtbpR3iNMUsdtHmeRzRc4yhv+alHPUgsF3f+GtbBmSz2vY3Go/Wgh
	 doVAjJxGfMhLZatCf7e7SjItMbzKfJqpXLgOdPVPJ43aZcxLNt8wkSCZLQeB1B4tZsWYu
	 VEbXWOGg2Lp0sYuuMWSb+4YFHuoW8pA1V8eZESv+Oi1+PJXfHTYqyQlb8DBNmcJKhsibu
	 4z+/2pGjfIb37uDnXJX7Ps8oPqRtLIQQHsxI/zhBhdPfcQFpukgrr23WPz+ID6a0GXG1N
	 27AnY3BmYWory6ng2BwBL1oQnGFGmmgTMnQ+CGTwvGH+McyTyAj9+Ranm2fNRDa2BGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RolwxRoQLA4mJin9vBdQpf3oG/PEdLsxtoKEj0r9vc8=;
	b=JX+GTIHTqY8kSsNJfR6it18yK8UOobPk5/SAU/MCJuGkQLJUppAZ5CUcZtkAdQj/rTct
	 x3MRMB5Kw6UIn1KRRDBXsOvAQGfqfqB1d3UjkNu324WYkKgAAIbYWu57G4416G/X2ug3t
	 k5PK6fsu2LLSOL4wkfHGUW4VtEyf332pcCdEy5SmEwnUxJ7tzyxc5JIRgLruXu9L3MxPo
	 XwO1VxzVilKn3pwIZDyM5St03f2on4JKNDGjbTxIJVArJdIf4A+atIec4r4tQYBGrcL9p
	 yuWxxtlWwdMT7zgBefMYz1KHprSr7Ba2mlCBXzayG/vzAyiA3mWyrpcwS+cJYMrC4kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUiapWpU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3B606D815
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F3B606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUiapWpU
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ab39af88aeso12070991fa.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:51:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793811107; cv=none;
        d=google.com; s=arc-20260327;
        b=oz9+UMM3CVVHvVOcOat9C56cuvh8H55mR728vHJvjN7Wh+RzLxD1IWQ1yMPCHzmqAI
         Lx8/dhthXUi723U/2DoNyal63nTMIUdtBm6Q/SUm0QHiBRzZVBX0vUymDW39hPUPjX0y
         KTUCNjuTolBZxXdwGFY2q4Yd0kCDpowJcQxf5w4PmTuWzhXpWKW6qvswZKvIy7d69xPx
         wskZBqIaq5gXgBfGqZFMWQQKRr+5V51icJkDFHpVVWYJB5+FKW2GDGeIrSi6ZEnsevfq
         Yml8q6qZkpDC8/Mq372i7iiKlraiHw3CndlGD1E/xLWxuWM/zR5OekxdK+yoezuERVyq
         Ummw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RolwxRoQLA4mJin9vBdQpf3oG/PEdLsxtoKEj0r9vc8=;
        fh=S8qEIF54J7KXqDYRJldDk7Oklc6zicKUxLni5mFZ4BI=;
        b=podv5qVpTvmjbfbN3GkFPrSTTlufmbvt/hhaLcUTtxxBRSXVTyJfj3E9IxKfYcjDmI
         sg/Ziw9jxtQk3Tay3xSFYr+OOWKQJL3GMl490CwGgER2DbkNq73SpgChqMjWMl5QCYSK
         H1rM8KUVk3pD1GKOxdLNCpIlvv6k1jioxFD0dGKnI4XFlQY95klFSEFgpn9i7AgBxjJo
         Js4AiaST6dznud/L25oS1TksmhHBrwSmKz69PaZawOS33pa67vhYZQUgb5/BHhAiy3ar
         CbZRY/JbzAznLA7ARBjBVe9ncQxC487FqTqYg7LUhUpQhsGL6jd6b7oKzN4CDysFufXp
         R8uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811107; x=1794415907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RolwxRoQLA4mJin9vBdQpf3oG/PEdLsxtoKEj0r9vc8=;
        b=sUiapWpU33bD3PNfwz+SBizdNBHjR8BaT2fJ+5L6GKHpvy4cePKi0+JskuCdR5R2XV
         O8PcNGys79ueKjGy9WV3w8+Tfi/I0LG5OG92ifyrQiqmjmiu5DujThDT4ncnuivMWGPk
         tzsqX4w1JkWt/TSznuHAkoayvQaBA5ItudR2uVMIkkPUUTXutnNzYlG7VmplIceW92iU
         8CApQT1241sCxEXZ8HrmApcO2i4ouqe7QGrvQsy+avtrB3OlKBKZQMStrS7OSDcXjaJP
         fIuZh2Ghw9Bav09F9QN7W1Ecttt5+QxLEHs9wHvPRvsslhr0QG4WcMrq63TN7+Jr9s2i
         C9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811107; x=1794415907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RolwxRoQLA4mJin9vBdQpf3oG/PEdLsxtoKEj0r9vc8=;
        b=np9D5bGOcQYF2BMqDAavwYWWckVoxJi7n0QoLg6nWAwx01C0m4nflIBG6r9ODTqJ7W
         WclcFSIhQgoJtwNRMzbBt0kRR+eExIy27wr1gOc4+w9KEI2Xzb1K8PlgHVSwNJN/CfNn
         VvI28HowoDIbG48l/UW+AcJ/VsmufnWgXl3HhymNeYlNcibEwCFYaRu/kOlIBzkP0L4t
         3bU6ySt2nhRbsb1nZcTNIUQhI72Cwn9HyxmtxxpHAx/qp9gO+NjUUH7J31cKDCmo2P3K
         ELp+hd6rGXR6R2XbnpEHWLEHGrjs1Hq/+U61SWNHllYMj2AyoGV1X9OV7Ko9Drxh7SnR
         Wjxw==
X-Forwarded-Encrypted: i=1; AKwUvBxVsUV2OQLvr9T+2pfj0+jTKFT2WAlbFZpnpU48iojUXdV8YUNVYHEbopNrADyyWMQCJNEHuTQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UUIzj3xgdThMjHeWXsAa0yLbUtdpGuOfn/+j1zCIcGUBEmqrj
	FlH1aALTn2HTBZbqAsqi98hgW0RQK7oMt1eQ6nZ6VVXf0o2XJyr+dwyK1oBfpZddY48HEfV5Moa
	ojDDTPq5h+KbpUi8Uiy3+YvD5HVjCSjM=
X-Gm-Gg: AYBFou1F2g+G74brxQNljyjCojKq9G6EjHlyBrFLTRX2Bqs/GOLOc7qdbAhsbixFpKF
	4ZuynFA8U8ifX0vXgoOjP1hGk3MrNEQOET1O1H+kR0A+I1Td3TofAsS87wc/Sa4m7dAp7yLDdaO
	VmYyAFiyyyPYl5d8GjkeHiVVUbTbDmp5mUiD/SAKOQOCWYwD2EDXYYh4N6Y7by9HRqEVBO/EgMI
	BrBqS3FzGrciDmrFI8e/oL5us07Hsn33zJlm7M7W+70oYHfzRp76cPty1YUTWYaULCLekwN/d+o
	bS1kEJuNS8xliLxwhCycC3tlfVq/7Uf6Ch1Xn2ZaqcrnCEkpJPla/et4oRA0Arkhw5W6er5vhNO
	e8IMg/W5gVpzeE5U2fue7m/1kdB/tJfp2WZW2D6Esgsf/jXKyC1x3PjIwm5OL
X-Received: by 2002:a2e:8a88:0:b0:3ab:4014:885f with SMTP id
 38308e7fff4ca-3acb7ad2de7mr37137611fa.23.1793811106978; Wed, 04 Nov 2026
 08:51:46 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104013139.1341582-1-bobby.prani@gmail.com>
 <750560f3-4c5a-44fe-b72a-0611be383f32@kernel.org> <CAJhHMCCu8ehOU37_4UpExNO3U8YPygjnht+2S+axkxTwY8bx2w@mail.gmail.com>
 <287698ab-76dc-4aee-8e6c-db1f5d18974c@kernel.org> <aus4ag1KxpuBNSP1@gremlin>
In-Reply-To: <aus4ag1KxpuBNSP1@gremlin>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 4 Nov 2026 08:51:20 -0800
X-Gm-Features: AclHuK8lUkRtT9DIM2v6hdb2JEoHz8N8QglBfCOcEbvQSbdRZXUQbv2xSsHG0dQ
Message-ID: <CAJhHMCChBTH3QWBFS1Hp17zj5HepN6KFucvG_5tVdpaB4fjCYg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/rmap: use release ordering for small-folio
 mapcount removal
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, 
	"open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Wed, Nov 4, 2026 at 5:55=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Wed, Nov 04, 2026 at 02:37:39PM +0100, David Hildenbrand (Arm) wrote:
>
> I mean 1.54%, theoretically is even less convincing for me :)

With reducing the strength of one barrier, I think this is a non-trivial ga=
in.

>
>
> In any case for something touching a sensitive memory barrier operation t=
o have
> a stronger argument put forward for release ordering being suitable than =
simply
> stating it's fine in the commit message and updating a comment.
>

Can you please explain what information is missing? I think the commit
message has all the details of why release is sufficient instead of
full barrier.

Thanks,
--
Pranith
