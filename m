Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481E3AC0C9
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791345460; cv=none; b=JDr7aIu01ACGor6DNAIpmkZ4u88aNw2exGfS2E1YDp04IJbxZhyXnydkwdKq86TKOxyepAvPNgzTdTmFvK1YwXdBjkDjulCdDqxUeCy8BTwXShHVXFv39HZkIhIW78bTp2MphfzqUdjIEqZhXI2hDRk5L5xUnJuk4hMEd6+O71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791345460; c=relaxed/simple;
	bh=uexnZlKrJFy9Uv64ru4W7iVry9vzMzmyMFMaf9QdqQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0GRuyFu9sjef98KpAseqOGn0kqRfuSFdHUSTV1y3OZAA/IO648CL99m9kWv6cP+JFeFYgWmWWSOajRGiTbnLUsnRa9YjjgffZwHadP3FXpo9tDB7mc5QsqeL9KaVdKmjZKImQCv5Jv98AaTD8ApPYqGHkYXY6AlhCUY3HG1Ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5h3QAXE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5h3QAXE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so775450a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 20:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791345459; x=1791950259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uexnZlKrJFy9Uv64ru4W7iVry9vzMzmyMFMaf9QdqQM=;
        b=l5h3QAXE0N7K/vC22Dt/Wo4sylxj5fnjPmzDOeK6vYIovEzHI810FwAoTlCjHJIVaI
         BCmN7Tt7ZzMVq+rR6bd1/bohvLYp+WEW5nfBt1ERaHMhUTA5QTuZ8QillKr9HsHStOhl
         1NxoIkj1yF6FuFYdwQTE+gpC4qGU3ia5SAqWlZrf+wSh9fdXXNIKmDyc6JpFwrzRjWUP
         Qk3hjnpqzWT9cCYKHmrZRMLqu9QrB6omxJYAjf3oMLMOtsYZUDfyOYF1wQ8CuEDELylQ
         tmrRJyYl8PpiF7q8tKWrohuJDZFyInn6hl49TVEouQGZopnqzHbT7D7OhigIWGdbKJCN
         aeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791345459; x=1791950259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uexnZlKrJFy9Uv64ru4W7iVry9vzMzmyMFMaf9QdqQM=;
        b=vrpFSN1leYLLBPRjWJB9JSHP1v9RE4SB9MH3dV7M+Yod0fzpoc06KG3Cdcgj6Esmhf
         Vmy0inSX2AtLok61ZvO+CjaXDWm6FfM/KdzlmbDOsRS/ayyLKg0s2hw3vbtplcreGJ7p
         dCY6z3/IChd75KR3LrqMqaRx00yt40edPkj0FkqbvfkuaoZXYNcNv9SAJ1WLj6Q5g5aZ
         DIP44aSNWd4r//DhE3D63pCW3WhV/3xirL2hl/c7A61x3eC8RGOx3t+z5T7rrFIWyHzC
         f5te/pKPAUt3otkS0qTtxtUvIm3KtComyGCY+JUnpBEPS/BIoHQsD+tm1Kto2EraTHiZ
         C0Vg==
X-Forwarded-Encrypted: i=1; AKwUvBxyEzF59HJz81TqLbw461XRGL0UY+G/wTves1+qxy9SVbPbmXevwXgTeEP1qrMt724jEnRhAKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz1VWO4K0IO1jhEirWnGlUnOh1S8xhgmzIPT9Q3oyVkza1qlzz
	u1KFC6wt4WBypSsY60nGhu9n7hY71out+JSD4ep08Xly5nJFXbMIBJRjf3blnQ==
X-Gm-Gg: AYBFou2hiiH+72sCLoqILkB6XXyG99he1p7gypFF2hy6ffZaRuxCmDXWC7L5pj55WV/
	+lmSSzwY0BO7PdIe3W11vunT4JQaqc+HD/4fIEO3uVtGDvOkHLMsII8WZYjajk0sMRf+QqeCAl7
	SMQAsunNmbbeC3mgPdOsa0sCmGQ1rm9SaNjeQELkuK0h7EUQVa2P8vL39/KkQN50xVydFPr5hEE
	erZGVMYuvKY0KLy/yepWFHjBdKKPN7W6uKrLe55wwcITPWUsHKmJcf9ZS+AW+fWGWgrLTN3fXpa
	YKUQYxaVLGyIbnJVidJHITM6fB+MDikeH21xvpEbLk78/nNf8/1nNQjv+7vUQ9uLqHzl/vheJe5
	kvEo+Y7k4dNKjpHKySWwQb8eQ3jmtBdMrRP8owFt81+7kBaNVOQzQlx3vSMgFEis+W2RPR9SK/Q
	KzobcRw413rl1LHe484NclTfkpAcTvfb5qZ/mis6IJBlSoTqpHtCIBBQpqKUIE4GbcjrTOn39YQ
	vjscgnMVdE=
X-Received: by 2002:a17:90a:e704:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3a8a0e0974emr508925a91.20.1791345458952;
        Tue, 06 Oct 2026 20:57:38 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853e66560sm7888387a91.6.2026.10.06.20.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 20:57:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev-bot+sashiko@kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH net] sctp: revalidate output stream after association connect wait
Date: Wed,  7 Oct 2026 12:57:23 +0900
Message-ID: <20261007035723.3470881-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADvbK_ed4ruZjf8CV_jGN=JPkJDHwwZ_9vx+q3zdHnFYiW8dLQ@mail.gmail.com>
References: <20261002010449.3689454-1-4ncienth@gmail.com> <179124882160.434549.10169630192303444846@kernel.org> <CADvbK_ed4ruZjf8CV_jGN=JPkJDHwwZ_9vx+q3zdHnFYiW8dLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. Both findings are valid. V2 uses the suggested range-and-extension
helper at all three points and returns ESRCH after the connect wait, leaving
the existing caller cleanup unchanged.

pw-bot: cr
