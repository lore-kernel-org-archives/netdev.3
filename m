Received: from mail-vs2-f32.google.com (mail-vs2-f32.google.com [74.125.227.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3974BA1CC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493417; cv=none; b=O3HhgiK1FCswFY7UZWfdcTroT6hyyKGhGgnHtOPQJHh9eBchlDW0pM3ve4SiYfQwPaBCwntTpzs0GTCxpTL+7DFOXghx8WIkpBYXhRJqSVFOzRbj7E0Wna42yLnWSqri1albE+ai3Isyd1qAb7sonVdxYANhSiAIRDRE9NOgPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493417; c=relaxed/simple;
	bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk/ycY6eAvdXGQd7yZc3ezHNoX9r5UpSIJWSOklpV1BOWEX+1cprzDRuLxTDtnpKqcH6q4uu9Xg2LeL5kxillz17hERa6mo+jjXkMUw300iGamWjK+MTg1o+HysQFFyv7/XteBa7rdounakRkYqgNyiRL6wcBt8QAnTB3k6igis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Wn94Bz; arc=none smtp.client-ip=74.125.227.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Wn94Bz"
Received: by mail-vs2-f32.google.com with SMTP id 71dfb90a1353d-5c67e4d8d8aso2955305e0c.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493415; x=1790098215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
        b=Q7Wn94Bzkc0cPJ3WhAjY6HMdYj55Ak99kYmdFGRsQ/RnUKkkAUhbWXHtaybCdDWVe9
         I19BbxSTX7foWh5AoY9YQVQ4nwoGn35AoabaS5ctUSbsnvDfk/nkbwplYCvqG0rSM+pq
         EQ/84oF8P4tQIf47narpkWTTB6yE1MaGsoVOLLgxG7rBNgieObAE39WOnbqtGIVCXOyn
         yq5D4xp2hcnD8jm3G/rfg9gqvj0DT2Sl/zQlTq8ejzQZmHyvS5zxm5sdgT1xyYTXrXWm
         xNGmj/zJ+S7+MRpSwsOn3N1fp+/pvRpHQOl8+hCWarQng7vZ5sEmEmHCgBgU0C/Eun3q
         z0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493415; x=1790098215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwBUcuZPFg1BLZxP9DxF8spw7i/So+6y5IlyEFSLMuc=;
        b=VNXU+CBE+VDwL7XmRyXtNBi8gP52X8g5U6l/JoboqvYwTFYO8+H70sEYwigKFc6SZo
         /I1kGtv/1ngsWEr3nTq5kFRM4wBYlEAwjb3B5tW76BkGCcfHQY1Q7PzXnyP2mEtPJrU1
         enWXknJQEpfkKytuJoemL8IZcsLLTfWpsDsgb1sf3KBZtcOKhglsobVD8UF8SLm9o9TZ
         dkeU65vrlnE5eu7x690EMJA9QKjhg4Qn1G0Cptl+Fez8MAYRuIU0jTCRVFyGNf9e8ZFh
         MrWc3HumlDfETykd114TBOTwGRe6wzD3gR6jVGyf+3RsoWe+MpgrdP2sL707mMUS3U6F
         /3ow==
X-Forwarded-Encrypted: i=1; AKwUvBwF8JW7b8q9yZcG0JCG9bFtvb8tSAP+ndBgfQW+In8vdbWIc6PqYFmvYoJ8oDr8w55iBoB0/VY=@vger.kernel.org
X-Gm-Message-State: AFuF++mo/ce6qWwxKbu5tP6mgZ/7EFJhDSXfoptxA4Og9IiTwsFq2N/R
	43fJfMAzj2ae368qkAwxYiOPzZGIQScggGQ+vxnoVfuWgfO/Bp44+/fEFT2ALf3ZcAo=
X-Gm-Gg: AYBFou1U7HN6sGW9spO0B0QdLxdl4dUEvZ2U+0uddI24WQ0Qmtqu7oBO35eczC5XhRl
	H/itxznqdBQOJtqaPchBfA8ACebZcJgx+LrLZ50CEtDVFC+vLL6QYZ0WK9lfr6faIrO03DVUXQa
	irP5n842i4BO1gGYpY1J0JMVsmgkVxp8Fx0HiE/OF2z52Ak1XU2zWdQM2sXcJnNkts/qtB2TT1B
	2KM7TuL0N8x1rm/pIvTK8qvmzLyXqd5h/5f5AU+yuqd0LURUWDs8DmCw+KigqmswgmpC9ZiI5+a
	xWud6qkNsnBR8g6BnYKAC4qkOsWMssAcajhY5rFPubWmkzU3y4dGfqPB2ap4E+zf/gi2ZhIEy83
	bRAMnjaVoCaQBRHkHkwfqwSCG0eXvydqMXvTt3wNLhBG7NBxBcoEdqV42XkOYlX6AbZuxuPSyf0
	glFKSDrOEEzIzXYBhcWhyIAytlRojzFfTxNZv+kH9bpyQuemi8GeQ2TyAbcBt3S4iM
X-Received: by 2002:a05:6122:894:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c981d87e33mr5580194e0c.8.1789493415229;
        Tue, 15 Sep 2026 10:30:15 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9989fa82esm153202e0c.4.2026.09.15.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:30:14 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 14:29:33 -0300
Message-ID: <20260915172952.3174810-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luigi, Stefano,

Thanks for taking a look.

Luigi — nothing fancy, I was just reading sysctl handlers and
noticed that __vsock_net_mode_string() bails early on a zero-length
write without touching new_mode. Since the child mode can only be
set once, an empty write that sneaks through locks it with whatever
was on the stack. CONFIG_INIT_STACK_ALL_ZERO hides the whole thing,
which is probably why nobody hit it in practice.

Stefano — yeah, makes more sense to bail before calling the helper
at all. Fixed in v3, and I added the CCs I missed.

Cheers,
Aldo
