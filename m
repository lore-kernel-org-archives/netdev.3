Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28D2E229F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824452; cv=none; b=ECIQtxc1GQ65q7ssZcEGmqshnsJUi7iR8kMhJSDSeJ/6k07VDiCNcdcgSe0tizyFYm+HL10FyZF31AOtuIDRHnRjINDBvrUAOVcKsAICfTN8LcyEtnM8QxmxngLV9NQWIbB5rdAXFT/w5K7brBdE8fN4rUDxJ4yIwPBSf4Xdlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824452; c=relaxed/simple;
	bh=YHRxEnhISzYbhxdYgROze8JOSodjmfiGqLyBf+tRR8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nuZ6CTCOjiA+HM3oEHjAHmmQdRP0lOTsfs3JWGO7CFOjnIS5m78rZkSMLjcJl9z26Iu/h7LL5lIPHJ8anHPSddF0r8cSyxHcuufj6yM4AyB+RwJ5sqas8KEfoHe0D4du0vNDV7AXSQJoEzTCcP1nlpSNDqJfySWoUT4O9TIryvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CKJ7JyBK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CKJ7JyBK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D1001A11EB;
	Mon, 12 Oct 2026 17:00:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 383C7601A6;
	Mon, 12 Oct 2026 17:00:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1AE111D70C58;
	Mon, 12 Oct 2026 19:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791824446; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YHRxEnhISzYbhxdYgROze8JOSodjmfiGqLyBf+tRR8k=;
	b=CKJ7JyBKbL4O8BzwF9cCKd0MdDQRTYJrJYWMs77iGiqK2BQ2wUKsrt/OhkJ29aA0jDYh1r
	5a1Op8nOK7HOUB7qpHF7CKPL/rlCKI0z8qZ8OiWn12QKB4P1rPRPcOzhv82RToQcUJ1JeL
	aXapwAVZr0lw7rYLeHJBaMt7EAlXSBdjPJLjEWxdJCpJfAt1pljtxy5/Qa85GfKZiRHzo2
	etLQdw8dPEYGar/96PBHTaQoYxBi/umQRQAPklXRMN1pB9zNDCXGhUocoo5EcHhij+ESVj
	CbuCAOGJ9Nn+/3BZPn14al351SDkCD5YkTu7biyL6i/ts+48dbaWcy+9etGzgw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aryan Arora <aryanarora.w1@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  David
 Girault <david.girault@qorvo.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during
 hardware teardown
In-Reply-To: <20261012120934.64632-1-aryanarora.w1@gmail.com> (Aryan Arora's
	message of "Mon, 12 Oct 2026 17:39:34 +0530")
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Oct 2026 19:00:41 +0200
Message-ID: <87v77626rq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 12/10/2026 at 17:39:34 +0530, Aryan Arora <aryanarora.w1@gmail.com> wrote:

> Scan cleanup uses cancel_delayed_work(), which does not wait for a
> running scan worker. The worker can requeue itself after cancellation,
> leaving an active delayed-work timer when the PHY allocation is freed.
>
> Cancel scan work synchronously before destroying the workqueue.
>
> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Reported-by: syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=19cbce4cc656ecd4febc
> Tested-by: syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
> Signed-off-by: Aryan Arora <aryanarora.w1@gmail.com>
> ---

I thought this had already been fixed but apparently not.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

