Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551925;
	b=DxOjA59/x4/IgFWMT9PVsdqRY5nl2MprQN4Llc7BNR+F7bk3BHIikBUwX1I8+ed2vXji
	 eqTsdP2Qh8Z9K0Vx0qfHVTQqC1BWrxKQ1AjkgU4MJ+PrTdlgzln6rdUgmfWpfVx90m6qN
	 ndeACt/EyqkHiWolBf4Gsb+AXZs2nmlu2Ikvylp5Ot3TSqkT/tVq5kq4SpesM2CZQKx+o
	 JrwYWFl4CTxVWvbtvnBMuBbdscCHnnRnQUdiYMazsuC+ZwhwBPrndnnvgffUGqjlgaf7u
	 Zfw7NW2o3ydRjaxYdj3bGe6bZVhhSlcCcstO7/R7hGLlG7rbNVvxYrlTICCuHAQj9VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
	b=GXcYTRSLzOOSuDUoT9StBWiqhabmTRJzm8ug227yZlIJDmThvvcO4mOzlNbqRo9Apm3i
	 NN3q6xN9RXW/2UHrpXpiM9Slueje6UtEzRFupL6P+uRatc10TkUbkZgtLXxbcTyhrcrhq
	 SQrF+WWZjE9jGPBw3ROwawpHdQ6Pgo7qNZXY4VcnsjYk3ipyCxXPl9kpv0oDsxr5BQjzn
	 VP6ux3vErfnJluRSfLqKfk3wjL7j+GMwA4PLhAr2jXeZ3dqXiHDKakSd2TiBBz2dEe002
	 roU9OUeEEFR0PhMln0Xmf3auiFfml3d4j1qVpMfudNXc8P4hu00z5kDlcWhphI5lALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTUhIXqc;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD3606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTUhIXqc
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so270241a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551919; x=1793156719; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
        b=jTUhIXqcHD5paioHMBgpX/nNDFeI6GefwrBU5JCZ9L6hQkgDCCR5V9qDyK90TWxB63
         BUeHPqsNqUAWjxsKRzhiYWN4gg/2tWiSqAFA02QpOTMVZ8HDrd/73VlSzZ/z6Q6Zcjmb
         y/SpBz7FnPTQZRm1MiEuoSZnfDeQH8kZYfIu4tSt+PzCSc9QM3JzSGKAPbcRqH35wiGt
         iIVaNSX1r/6k7vkTPWGRrKb3k7KNyal3wwC2/NRW0KdNFdIthL0IVESKxGtAtYSu8Cn8
         cBxQ9fMunJcJn3KmG5zDQHXwvhba1VSFsi76J/0MovajXPhER5CLkwBZRb//TPZDUhXi
         dl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551919; x=1793156719;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
        b=Dej2wbD6LQ36/Qc3jCPbRwehnCi1CWMph6QYSwrPo463uoYzTsQ5REhfBMSmSrTJ2G
         cQgRiskOrOJe0jFhPBwgJLK86covrDkWyxBxftTYt3knxH5tUTzhox3J99Bwspru6/BG
         kTJpLARJ/9URsiJvH/PIl9FZJFFLegUruB38v3lak54B/6sPfrO0GNxCIQwphPG5R1qr
         sdJKzpAbdHBjqQxI3E2zvdjKzyNh94CNXG/fue3Kf/FHFmiCUyCZ7qwDd48AkV17eth/
         UObHwdtRtWtfkx3jyrJ29iWBp+EWoYeRjIH/Ai1SawJPHf217fUCGPMZJrlhpGckXbnR
         tRDA==
X-Forwarded-Encrypted: i=1; AKwUvBwQiDxbE6lkQRY+Xdjz+G+SLL9i6xKwXh9u05iWARx8mp/p1wFvfKVIab17Uh/UtxIt0ubKvQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsd4+kWXPFFFi7JCr3TfHEl1v5+6Miw64R3T6O+s2YBeyOhSht
	1urUGwed5JIpKKuCGUuAkvQUtm1ocy+msUWDJ2Veqpnjvzo14jRdPtas
X-Gm-Gg: AYBFou1as2NGvBJymnJ5J1V0jho0RYLdUvyK5SaTepbytSy5ComNKzKIhHxzyF7/0Wm
	iIDpyuv+7/EYJa5Icb/wcdV8rMTtk4nm4Sf45o6+nry6kbyXUcX2e0DM0R3QuqT2gGgAchtDxCa
	XWmWdWhg9/8QUlY8WLVBiaNltxcCu2cLTheUn+WLlVwhacOpkouiGUbRSHHltiAIoTULmacUL4f
	nw7it8nrfIZmubRBXFh30o3FZpZTcRZrSF0WlhJFaVNOglXKOOhlrbMamj+B1umZbLcz+6SDCje
	WcqNUJka2lx4LqBwlfwDcYjWLKtvFav3RtNRMs9GTQfW9OJfxYnizfRvrYN4Nl98foZckxIlCTW
	cpKBi3wZpZK0a2DN3a2sODx9LqvINX+VBJx4AWyr8pAvtiXRqyWoy7VPZQOZ77EURbTIXrwYA20
	XhgGb01U+mmZmnor3+7n5RZLEmA3eYqnIDhxds5N3Z4wRbIq0tgOcbq7TaJF3RTj0U+UsTJAt3Y
	3uuZBrX6wtm9n+YDrbI/68gqdUCr6CWLJnqg0WPLU0Nv5fYSyTqhh3kzbjJain5l3AOshLE+ZUq
	sxtuq/91MmcY1jh41bVqOangj4pbbWMFD09M4v098Gb1HdEYKEpW8fnpxmFI
X-Received: by 2002:a17:90b:2710:b0:3ac:7556:8ed9 with SMTP id 98e67ed59e1d1-3ad86c79924mr698658a91.10.1792551918978;
        Tue, 20 Oct 2026 20:05:18 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad812c565esm1924550a91.10.2026.10.20.20.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:05:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:05:16 +0000
Message-Id: <DMA6ME9P5EQG.3EI83DBIFMBDE@gmail.com>
Cc: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kuniyu@google.com>,
 <liuhangbin@gmail.com>, <mkarsten@uwaterloo.ca>, <masashi.honma@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
In-Reply-To: <20261020182700.655edf14@kernel.org>
References: <20261020152804.39863-1-leon.hwang@linux.dev> <179253001886.208021.6536312952037292688.git-patchwork-notify@kernel.org> <20261020182700.655edf14@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Tue, Oct 20, 2026 at 06:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Please don't merge changes touching core networking without an ack from
> networking maintainers. I haven't even finished mopping up all the ways
> the XDP link bypasses normal XDP safety checks :/

Fair point. Will wait for an ack next time.

Leon,
pls send a follow up asap.

