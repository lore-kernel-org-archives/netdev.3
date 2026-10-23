Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741059;
	b=S82qxGclp5l5D7YHJCKPfJztuyB8X3WW6A+1skHvbjU02lG6xSe89VV3QdMkFPshndtG
	 uIPfKYMJ85ok2sKW+cLp6i0EDY1pquW6Bt+EeqUVgL6mjjvYT802UL6gwGKz4yLC0G+mD
	 SfWs68NiIy8f+PYLE0+GWPppEj57UUaqQrM7fZ6V1o17bjJ89Qf0CFwOkogzEs7jGE7W0
	 IpXs4/Yx2HRUFt007Az+TQm+8FzHXKqgDl0D70+G8D3rY0Cj5Y8KrSQG3APdrF4DeqcwY
	 x88ozQXlBZaW4zqF1/3KTM6zxUa09sOIAoPIUoraa3RA7WS5hglaCS/qT7cG8YGV5Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/W7+697pKZHE+D8ZJXXPuDp9wLNG99eVTuseb9Fgv3c=;
	b=qYFUPQsbS+rb2M54/x3hwWovWRLnGC82zhES6rA0HeFjkhn0lWVoF19uq14/Y+/dJvgi
	 TcgXnScGaZqfSgJlxzIvcnE/FqFxcn8FcCp8JntuBsAM5JXKsPKouLD+aLBPDbuwYvEuz
	 wTYVIISRMG4H3DVVfl2/t89lDTsFYDDsZHRKA5gBh5F6Bhk5LWzM8OvyRPNTnyt814Cbq
	 nnYcikzRNqfpp8Sob038QbFCUBqtOF24hJeA4C6Dukgt008Lk/VItDKXuhe0GOPkQkefr
	 ZhrS+bd8ezsAxOW5XEXr+8b1PuR52mWjWAe76NGIdKF0yUx9wFXNXeVGLVzmWd2yjcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p9Y1RZW2;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDC606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FDC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p9Y1RZW2
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso203318eec.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741058; x=1793345858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/W7+697pKZHE+D8ZJXXPuDp9wLNG99eVTuseb9Fgv3c=;
        b=p9Y1RZW2cGPzye197/Eq2buSblrNpsRFp4EnUdf6e01GpeWxyVR9D8PspwVdAwv9dF
         qSjqlo2sz1sjdBLgIvbLLNSl8FhoQjVu8ZEBFoRZady0ecVG50rJBAvR/1kKNFI6elX3
         YjreTs6Wf9dyV4AiUcGsO/b+b07U2jEbW0aRtB8B9SndhwntAswp2+STchBPQNtiUPdo
         AJgTNHtbjUPx+xcv/b+vNTHBjBKLOxw0VmNh4T/8oa5d4YVYfQZbqXISdoP9D0DeHmWX
         x2ZZU4CUCc037tUvo7ePS7WrdiuVaal0NE3YPXTH8ODnYG+4D/F8Bs02EwxcMcOVtEON
         k2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741058; x=1793345858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/W7+697pKZHE+D8ZJXXPuDp9wLNG99eVTuseb9Fgv3c=;
        b=XRaK4jBxzJXqY5S/99ByitMkN1A5obsgbj9Ci9ImNNMeUDsi1VWftEps712rpz3f+q
         zRf+2ImW+PMWSgy/5YqKfQp9QnQvnd75ioF4csubso6dMg3M/t+6tHhh1bC+piHGhViu
         g6aKwwaGnqpcDA1ZLZpmLSD1qwu4wxvU7A6aHcZN+mvkeYwJRqyxKkeqeSCg1ISCYr7B
         a/UNJfOpq567esHN5uhtm7OiDQb9fG6wdO8CJEOGxcFiiwCxYHnbz3QiXJyFrYxveYgI
         AdxZGJObHhr5ktPNqhhbWHp1b9GwRv/vR5DRXQMBNfIzS+5FuvBErCIma1pP6jV7SB5S
         BC0A==
X-Forwarded-Encrypted: i=1; AKwUvBx2ZMVPGirZyPRplg6uSc3zxS1FGEbfQlmW1EPfSYU2+j5XRglNfSO8+fxmQe4GmuwCVjssNaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLglIVXLS64UhrLN5x45p+/jd+VLDPrIu+HrmF7zY69YyM1sdOg
	W/yelUPphP6FIkH5JEofdDUkwgxl066sRroAbBUi99S9DjVukriaBiSP
X-Gm-Gg: AYBFou2cfattcGQ7FgU/hzQxw+g8yGgn+5uT0N4tzZmiUBpGi8rkugPVPvP60qdj16a
	mkmbTZ8mZBDZhi5ePZcijQyqxQkS5LSPCx7cICYpktZhZlx2vm7IDLqMx6cd/usffMst7222hkh
	j1ez+LgSYknu32xptqqKNUXxpSEcOg77gf2bOl3Fi/TUtsNtZPUYp7LlF/yv+WL0i1je0veMXLN
	NOvGFB89NvFZZ0rNs1nZL1qraDds2SCbTtNyUSVZdWs/QMJbTs6axuQxdlcz+6BmYYVbFASVoTf
	LHJUwsZMH5g4NtA1XW3MPBVun884AbJy3rPRpJov+srQ/m7VdkvsT2pzukLDXsC+97H70znCJq5
	EubpeFuOiZ2SWe1LiIAGc6We/fKB5cR5w7zA31OkLkVNCtiLpzSr8bE+kt0nx3scPVLojAUWBNw
	aliuKLtuc+C0J28JaB2JQMDPVqOWARHBiANIov+jLKvlJRLQEegPjUeZXLsxyobSlA+vt40a2Pj
	Qu+LXH4Uvg48HrPkGgFJihP/hZITdXb2c3mwqg62+bE2x0sfrwdz+kzEJAaBfw/PyUJS+Iug9jD
	ksJUw1iDKYu5wraXsv1xt3+Ub5MRQCXq5m7WFdoDQdpXQBB4m3dL4fSiDvZWyhy/QuU59hDyiz1
	LqbTfsC75EpgiZqAxcq6GCvTx
X-Received: by 2002:a05:693c:60d7:b0:350:2a5c:56c with SMTP id 5a478bee46e88-369d97a05d6mr1926432eec.20.1792741057920;
        Fri, 23 Oct 2026 00:37:37 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5e9edsm4200927eec.9.2026.10.23.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:37:37 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
Date: Fri, 23 Oct 2026 07:37:31 +0000
Message-Id: <20261023073731.2436301-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <179273868210.3134.12145105670992560597@kernel.org>
References: <179273868210.3134.12145105670992560597@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 06:58:02AM +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] After this patch, the multicast group and GETPDP carry the
>   same PDP-context data but are guarded by different checks.
[...]
> Could the commit message say that the multicast check is still weaker than
> the GETPDP check?

Right, it should. v2 says it: the group check is still weaker than the
one on GETPDP, as genetlink has no multicast group flag for the initial
user namespace, and this fix blocks the unprivileged users.

pw-bot: cr
