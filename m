Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A74C7532
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367587; cv=none; b=QAYip3lTk21dwRjnvqJYATYaGj9NfT+/VpnJ+n9cmQdwqQfEcwJ/lMkAiLlYjZpKB8YsK12XLDEL0YRq2Vq/BpvJ675iNBVkPlVJBduOcoFGl57M529bCCMxZSb77T01s8IbmT8XWumKMOJGNkno+s4KD6SWzswT6c2GKlARfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367587; c=relaxed/simple;
	bh=K88g/NRBGmhTSI9GMeLUT029uyZ4Jq4cmaHJJxQ8Vt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgA5WiXLbMq8pBpCEha5aDsBA29EImwnpMQjxCmpmO+pnN6UsTVuvvP9nMZKxzz1+xEsDH6Fp/yf3RvBRRANoW7p3dvQFvlYPcJBkI7zj2w0tk7W2zmDVH8W9hgxOAEQhYJEXL+/2aY4AI1I5UXyYnjtJcJ4KfwXM9ggMEpWxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrC+BULQ; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrC+BULQ"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91400f92ae8so10393846d6.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790367582; x=1790972382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K88g/NRBGmhTSI9GMeLUT029uyZ4Jq4cmaHJJxQ8Vt0=;
        b=FrC+BULQVYhb1/j9jrOUrqdt/ZYfxlJiVnfWyHH3KaXcUwIOvVixCVhQNozo31vmS7
         nPPghoSW4SWNs0qmgGofdVV1ntYUaux66bibh2u/NXVajshJOJWNrzOlnoEcRt4XV+mE
         +lXhHb0YT0YnYcLcLbx/JLMyVi6KrNwio9Bc8HSHrfH3doGhu2epr50C2mnWKM9lFk9N
         gB7mS8Xkz0//8RKAq6QeeCNwiOlmSpvR1IoOAHzbUIHd45Yk7IThWiuBPTV1JCKmMRtu
         qO/T7Rfb6T2hNiBzQEgN/S3cz3wDY4q+nFyAeLlzqNZMGI1Eqc3DgKuB6gJCWJy38P+B
         Qzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367582; x=1790972382;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K88g/NRBGmhTSI9GMeLUT029uyZ4Jq4cmaHJJxQ8Vt0=;
        b=iDn9FdeK7VWisxxlRi49Iyv5PT8Er5qrIJvep2ft+E/02kFOxF69FfVISKYxRv2pEp
         nYRbFDlZX1N1joSCXnrakXjDJY/FRSVnSFT76FxgByHVPyv58ZTYK8v7KPrEsdnu+j1r
         /3cuIZcshReCgPXENrE+cGSYvc76fZy7u2NsE/CNXmudvCo4MZfyIMnFqmKNpuPl2b/h
         tjCuuxG4jZgIaK1nAOE9BzD8j0ZUjrQfyMJynTXz8FNSRkZerS2Z9PV5QZZlZDHeUZYY
         +1mecmZ2z3q4eYMKrShMItQS0EavTMIgveF3uO7BksgJTxCzyVxGO7dFd3NWMijhacec
         8ckQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpr1+tPbT7shIdUiAisJijewVmED716gI8TiCIH0zo+D4grbwiqavo2a13OUfa8G9lrMfYxhg=@vger.kernel.org
X-Gm-Message-State: AFuF++kYP+2j1jurBEcDg3rxvLIuuhg6G1nlciB+4TF8Xp3dZGsveJ10
	oH1AoiwjIDDAFLBWg/Z5Fd4bo0Gr65yy0YYmoqIDcfgBChcKwAWvQWGC
X-Gm-Gg: AYBFou3g2iLSsgov98K2iyf0tyFIZPN2leruF3fDy9NC5aISA3tVN8/JRIt7gqHoDcY
	f5jP5u1tJ5nj1/fsqNmJpU4Bnm9CP5klsV67rLUTazQVemPbd6yQacm+FM9uSRMQ1+xKWAGwU1/
	UytEC+UC8WemAnthCUSF+Ut5cDgj6sp5Y4bmVv0S6Sv3jlDiov5TxoUqruea4eX7Wb9gP9Whxmj
	BVCXlml90pPiNeRg8dk60OIwCVwuapo8aPcG1p3lXM79S7ncHzXIMk/IbKaO7GjThjpaR7PIpLL
	VQg0ZDcZO/4k/iKIoX0fr6Gc9WNpFA/1URhg7F7aRqCHeE2sNh70mmYsMSmMQdFk3QgV1QP0h1c
	OlkZjsACsizcGFJDsynlqNIbMy8Iy4LMzaW4nntx/W1vDIkBId9iLzCokrVpUqE9KjadsFL+JGc
	8k+FDedV/tJdP96dg+j8Rv+Qr4KybPmA1vIWCnweUZM4ogJnb2bNSJZsxEbIw3KsBDUeQsV9noN
	kEdYfW2xQvrU43e34Gg9KIFFZtthY4U1vtthvRcUM+aBDd3oCxN0RGEwfCOblw8pKhNdrupOFzo
	JIQnxkMH6GDQPQbkK4c6P6HTNpnBlx8ZC70/qkH08d+p7Ck+Btpe/OyBLquiOz7dH1nV5eNRS5D
	C9p35NT89FonR4GMWnL5ZPv4YLj2n0FoLOxXuadFfY6ktc8L8L8NlqjA=
X-Received: by 2002:a05:6214:d45:b0:912:3c52:5e72 with SMTP id 6a1803df08f44-9142f08e731mr60599636d6.0.1790367582365;
        Fri, 25 Sep 2026 13:19:42 -0700 (PDT)
Received: from edhar.longhair-great.ts.net (pool-173-48-206-252.bstnma.fios.verizon.net. [173.48.206.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914309a24c4sm25159636d6.6.2026.09.25.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:19:41 -0700 (PDT)
From: Zack Gomez <zack.gomez@gmail.com>
To: leitao@debian.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stephen@networkplumber.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] netpoll: bound the deferred transmit queue
Date: Fri, 25 Sep 2026 16:19:40 -0400
Message-ID: <20260925201940.1950809-1-zack.gomez@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <araTwjYJRMlfd2PX@gmail.com>
References: <20260923181111.1182838-1-zack.gomez@gmail.com> <araTwjYJRMlfd2PX@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, Sep 25, 2026 at 08:32:56AM -0700, Breno Leitao wrote:
> I don't think this should be a fix, honestly. I would prefer to see this
> on net-next without the Fixes tag.

Agreed, I'll drop the tag and send v4 to net-next with your Reviewed-by.
Thanks for the reviews and I'll be watching your patchset as well.
