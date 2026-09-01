Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FF25DB12
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266911; cv=pass; b=e2c3s4jYv9LNIgvIylAUQNNwJXw724Oer0NABf/oVh3Kk/Zoj0or8x9GoDVK66J2OhI2ATO8xvqQuYGFxRDr07AHkk2qj8ECYvIceqZaur6k1Ve3mxyGLLw6k5guwhD7MmaSiYueeVxf1W7KvbWYK6yukGothYgtBSNYR/yz4ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266911; c=relaxed/simple;
	bh=7t95l5tIyIrvb8GA058vJ22/PqoU8KtEqZHZXzXWxGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZyH53sOirC+GL0a4q9Z1iSqKBXUYaO6//o2K3gndsHZylAWNvzTGPZAlWWIClI2++vB2w8J3huF0VXAc2TBYwhKdMaH7ExNhfneYJakJbs7V/evbXjwhO3s+2Mj1Ol1n3NgUYOlzwYvtZpQZpvuKfuUpGvmFbXGjao0PWgiB2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVGZFuqi; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVGZFuqi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38f57e312ecso1049719a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266910; cv=none;
        d=google.com; s=arc-20260327;
        b=FfURLKxqVH9m7MMLC7jlL4/zSBc86l2r2zFK0YPhd5c/T5WEFOjqlc33ykm+F4VqyY
         G68kYHdEjbPXLify5JrlOXMxIpISklTCHa8wKgzP64678jB8OMaVZdpemU6dvhPr55l7
         BCezcPbq1bXrBEchpIQaD/W1nCDpcpn1vaK0S60Cam6xXEmYkM6cIZk3m7I3VbpCghBL
         UY7PwcwI/gY7D2UwfmsnomWtcvTnPByPo9yqshTz3KOXBNh5cBJ2OU8bQeyidgtEwooK
         sr41PrmtKe2m4WlhN9icZf1n7PHI1yhprjo8bKRJ8YYd0nWxSWl8+vJWXN1IycWxaXyh
         bwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zEO4ToO7aIfa8An2MxNmN2waWRZjTMnWleI/IMLu47k=;
        fh=wKLgumozKXiO/Lv59OZ2Qf9kPID2MA7RciELnPT5gq8=;
        b=TUPd+DQq+4m/4ZnsgmStvmD1r/8P55k357zbrALiey49I0XTDt/aXeAJGVfogcTcmK
         iPl9lcBFWgftPfTH5/a5tNAb2bBJx0HJyWRUtUB7WuB/VaF5BkOJYk32SyAc1ljOTInJ
         MHOQtBfTvNzKhPqzjIaSi33CpxvcQm0qGd3M4hX1JMBjahAFTNto4fS13yCPP5qQ8ZWR
         FJpo9Dc+x402ZKeQ3RZFrB4d5+jru9NOWTVtL2V8W65tPGPY/VRGzQ8ae8AZlz4M1cV8
         P7piOfFsT0u5+k2ZMevDVYEwtGCZplxImyM8CP9+laq9prMFbSI+BW87orK7GYUSLbKD
         Aaqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266910; x=1788871710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEO4ToO7aIfa8An2MxNmN2waWRZjTMnWleI/IMLu47k=;
        b=JVGZFuqigiSZi/EaDmVUstxXL81WLuTR7FSd8PSHaPThQDRyTh3KZdUiO6cK6OYsiU
         /nwRkkQNjgq3u4AO+IBZ/Va/G8/K+HmiGANVE0vk+xI0YCjPANowG+toN3L2/fYNCVhD
         wDYe+aTqZJQ+8/5PWMRj4xIL+LCtEjlufj18mqq/e7AaMvdJhlhQySvu8ZNLtCasq4Yn
         +yOhzqdSzUmOIYzAYhTtJkqfwIBu+McKU0tKx4BtJw9uO+VXlZlXCunW65n6ocb+ouSk
         v/F+E1gvVetigC8FzZRmWPAt18BNdo3zuJTfjl7hhMk0qcs7HT2OEBcsMsKZT+24hzMd
         Mg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266910; x=1788871710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEO4ToO7aIfa8An2MxNmN2waWRZjTMnWleI/IMLu47k=;
        b=JIm3LE1lD882S+xUz7wkPq0TvsO/wPUJaDd9dMICoFHb7qEsPj+lPU5hHVbwh30clf
         YWHLDp9wa3dNPQekrDcPfErUmQYHMxMQvBk7NrnsvT9BmKaE7HKJzuXANZ6IPMgaQFlE
         JmXo1P67kx/vpO/NKV1KqEGWi5TU0FvgcNcHK7oZqtZxBjo0CdYSgJm1iNbyZdGk41xI
         BL7ETcarUsG+sDQIdYTCNJigiEUQ8O5A+P44K0dhzZpuyK5TyrZUMUEusf0H9fHZn+id
         3UldA86rbQOCjU5jp7NjQ9LWQ+HYBb7wQ2X3LvZDUvuyLa7l1E4Opy6uMKay78PnYt9K
         eQcg==
X-Forwarded-Encrypted: i=1; AKwUvBwoV/czBwSM/kOAiJ6qJ5sQ1VriaoYL+pwn5DKJxIh0anl3uXFWIww8hHR+C3/7XzisJ9LOGLA=@vger.kernel.org
X-Gm-Message-State: AFuF++nYLMM0ors76x/3PR6d5UPjHtf8DS0V3JQBrZ5lYbTmam2+eMw6
	h1WFH7zrpPyxtvQJ973TKwd0KHaPeVRXFgCVWcqrbFD3w+0KroaieK0r5e33XOgtJOG4d/AVRFf
	Y1r98hKwZbhjHJUIA19x3TWQU9MtLCvo=
X-Gm-Gg: AYBFou3j/mg6Sm3eFRhN9zIEt6Wci1v8giXQqDQX4+H5bEJhTIQ9zutwfJ3E4I96jFL
	0T1zJeeYomP8vOq1SYjBHuI8jNP2HOuIBT7ZZh/eEv5+gr/NoVrEI80EgFWEAIifGpgYdPSAKml
	0icKBgr/5qkQjiVnxGaz7hcwyd20rJywflMzdi4uk1ZfNkyzH3I2tXqXhNqVXPHSPdc2LyyX/6Q
	oC6N8rD8vuZOf1DBiMvQa57B4HDu0iqMbG7CNiAk6Ph5KAt9xUlF7M+flH42far5AY0TDmfT7/e
	i9DCyB9x59PhicWdSyTMO4IV1v5pyTBT5Fz8BNNkRJuXceD26akAQl4t8mv1+9egIinOapG/nq9
	Kxg46DZzaaRkwTdhVViO8DjeOIU4FEW/Me3UfhY/ckPsM/pvkTEVC56d6pbPv8zVXpNJqqb8=
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id
 98e67ed59e1d1-398bac026a5mr20438534a91.5.1788266910057; Tue, 01 Sep 2026
 05:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
 <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net> <CANiq72n0sgSPQ6SmUbK+tv9S5VZktA7g5XMjHOBOFNYLo2oA2w@mail.gmail.com>
In-Reply-To: <CANiq72n0sgSPQ6SmUbK+tv9S5VZktA7g5XMjHOBOFNYLo2oA2w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:48:17 +0200
X-Gm-Features: AcwNN1WnWizbjOWWN0pUKb8lC0ggsF-jOAgWoTP8zR1n3K8yJhpg0iqGxAVe_1c
Message-ID: <CANiq72m=CJ7ngSBrnteyt07fHNRJ63J7m+=LY7UDHLmwYKjCJg@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Gary Guo <gary@garyguo.net>
Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com, kuba@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:47=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Definitely, if the patch shouldn't be automatically backported, then
> we should limit it with a `#` comment, e.g.
>
>   Cc: stable@vger.kernel.org # Only 7.1.y and later (requires
> bindgen's raw pointer accessors).

And then we should have a custom version sent to the other versions, of cou=
rse.

Cheers,
Miguel
