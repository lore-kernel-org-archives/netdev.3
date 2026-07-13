Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973B357CE0
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974580; cv=none; b=fjxP4bHePAR3UXzEuR2fuygc91fwt3M8VSwPfAflf51T5vT8s29WQ0DrWGUlxssz9vRvoVA/jMPAm8oJV51iJJ5SXI98O2oPcGc6kAxmCqSK0cKE2V52ZzZiVWAXNiqMSZG/ZlpfZb8ubjCWIBz8duHfJriN4fUfoQPVX9j+CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974580; c=relaxed/simple;
	bh=x9tQjUWjYVsPnrJSRs8ZwJKtHiDSOdJeKDqHoYOL4Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpzWpwvG8ZJr1oNxUgXFdAW0sCZFBnhZImnB/iD7ucRuBfnPwDQbm3sqV5qUN6kh46f/9PHn94Eo6WLV90uTXx+7Ydt68rsWT4GnEeEdpq8Hr9l8lkv5VQGtHXl8FAh2sGtdXy+pEzYoAEWYGn5csotElfRPHVuOCytsom+yYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL/4Blut; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL/4Blut"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so31935525e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783974577; x=1784579377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9tQjUWjYVsPnrJSRs8ZwJKtHiDSOdJeKDqHoYOL4Kg=;
        b=RL/4BlutHr2b1g/WoWedg1TTfxqOZYtzhRJly9tQilDBxWqxRX28ESzvMVqOp2negm
         RlQtQdX4iV7hjoFbzsmL1CU8hORTzFlsKlDlpCBFaKJPJF+xtgY9g0GIviBk18dspzjR
         e92Rcr8R7/9+j5B8XLJhAVu0/cbKezoYgjosP+j5zSFQCchu66ZkD1DWcjbnxxEv0BYg
         46c9x2B/7PVrsFW6JqLAvQxuOJrD/yH0tUTYmVU+RC0eAMeVVozudrnUh6ZIUAIJnlnJ
         /puQgK2OHZp+IzJg+LS9md8CBNAcGV5hKlu1aydw+KG8ODWkVY4q7Z3Wgx38fWkUiuKP
         BLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783974577; x=1784579377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9tQjUWjYVsPnrJSRs8ZwJKtHiDSOdJeKDqHoYOL4Kg=;
        b=ZhuxqYF+SrQVHKxXy+wUO+XxKDJhJfHiVDswKeGhx2xCyMPHQvEc2qVHFV6i1AzpJV
         sc36ky7l6+BuvrIsMg/Jjrc9wZWoxEIUV+bW9U84z2fMbZtpdENDiTRl2qqlhFndDHUA
         wsxI2DOB9N04jXivcGfpMVIqpespTQT6LUrb6OVJv79Whys8lHsL4Lgs5VT/rbUXM0YN
         c0E0oG26Nq7At8bId8JwLZm+pdS/OYHlDmVkMzNjffuV1eZlmMo5y2PGoBQ+auN5+F33
         Svzut2iIT3Dc+UXcTSh4nwZqsQVo+rKgoP7oo6AadgXeKRYRHHTqAtpaBdjMx/NGJKLj
         NLvg==
X-Gm-Message-State: AOJu0YzSYIAkXsMPpKHdRqIp8+wNciFM1EdLrfH70d5KhgM75XStuJ4Y
	tWEt4YPinMd0zfGFiZ7S9A8scsJH7fZV89+5UN6b/v9PgfMuGGn6NigHkG0aoPl3
X-Gm-Gg: AfdE7ck2LGK9bdrAJA+APf3bk3f8cDLtVTw9vrIOjKd/IrycmyApPP7yGW0u9GjITEt
	GGTQAWcOBIuJcX5sK6tgc74WXJxFwpQZEuwZRplQnwJOu6EuIYvjMSmMAr+Kyf6qC+DDzuKsoaT
	s4ngWfd7aXQSLjOPy98MmxkuGnxkdqU4aa6SpkFSU6kGcc7k7jzNyTagUUFp2EIxvBLXmq4mXur
	jb//n4oKxzBk5KaoQwv9joN52wyrDvAfr3Dg4QX8Ogj4f7+S+1xASB1ftZfEmNAIffAHo3vQav2
	7eBuWdr8UcNV5T4t6dJTcSRPMz0kb9O3x+trvOr3l8wwpP5fZHTu1rSNFrgzEZ5yu+YWbs0l96t
	iogY5aKqM3H3b8rAgyTexZx/6dGDiD9orpKkGu3B90MTKJVB5GWJksNqDaSQxEeoIYiH0y04EFp
	kBNjbbyvAi2EfTVL4QzQ5ysbajlXXioEd/nwLIYPU/7GGVd/TDBrOuj7M7PtCmo9DW+TE=
X-Received: by 2002:a05:600c:a00a:b0:493:bf88:edbe with SMTP id 5b1f17b1804b1-493f8818e35mr107750425e9.19.1783974576636;
        Mon, 13 Jul 2026 13:29:36 -0700 (PDT)
Received: from localhost.localdomain (i689755CB.versanet.de. [104.151.85.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm244525385e9.2.2026.07.13.13.29.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 13:29:36 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com
Subject: Re: [PATCH 1/1] tls: device: push pending open record on splice EOF
Date: Mon, 13 Jul 2026 22:29:33 +0200
Message-ID: <20260713202933.48674-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709224436.1608993-2-rjethwani@purestorage.com>
References: <20260709224436.1608993-2-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 9, 2026 at 4:44 PM Rishikesh Jethwani <rjethwani@purestorage.com> wrote:
>
> On kTLS device-offload sockets, sendfile() with count > EOF can reach
> ->splice_eof() with a fully assembled but still-open TLS record left
> pending.
[...]

Confirmed on ConnectX-6 Dx with TLS 1.3 device offload: with this fix,
the sendfile() count > EOF + abrupt close() case no longer drops the
final record.

Tested-by: Nils Juenemann <nils.juenemann@gmail.com>
