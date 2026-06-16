Received: from strotmann.de (smtp3.strotmann.de [46.38.233.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92950395AE6;
	Tue, 16 Jun 2026 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.233.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594529; cv=none; b=W0RSuoSeEbAhVIOnnUPsB2x0VVpwB3JIhkz1KAci3OqO9mjhdU+q7UxPOUgbHymYhkjHqrT0GwB4PkbYic0BW9iKqTDw0DI+Oe92+WGcUW4rkyCDw+BzCaGbvrduoOahx9woapqz6gkfm+HeSPsxMU5Qv7jzujWq/O5JaCFzqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594529; c=relaxed/simple;
	bh=juhXNLlnPzgyRynEqG91o/WPu2WsUH4/kzqpgpcpPCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5WUzGM31oMENvJAC2CG95dwlnvUlXsPDEKW3w0kxvNQw0P1HNTKVQuqPiYCle/2+kjPnNU1N98pfs39Y/C3pSwfswlSQEgMbdhtkcyySM3CJLzsWv+D920j1QBPCGhKV31pq/mcgrR3gFDAraa7QTfcW5F8x1FVqQ059uXcgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=strotmann.de; spf=pass smtp.mailfrom=strotmann.de; arc=none smtp.client-ip=46.38.233.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=strotmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strotmann.de
Received: from smtp2.strotmann.de (unknown [IPv6:fd01::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp3.strotmann.de (Postfix) with ESMTPS id 495787FE91;
	Tue, 16 Jun 2026 09:13:56 +0200 (CEST)
Received: from [192.168.8.114] (unknown [IPv6:fd00::1000])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp2.strotmann.de (Postfix) with ESMTPSA id 4gfdWb3KmCzHfrn;
	Tue, 16 Jun 2026 09:13:47 +0200 (CEST)
From: Carsten Strotmann <cas@strotmann.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Date: Tue, 16 Jun 2026 09:13:46 +0200
Message-ID: <A3590144-073C-46D6-8425-90EE0C4D48E8@strotmann.de>
In-Reply-To: <20260615175535.5bc56cfc@kernel.org>
References: <20260615222935.947233-1-kuba@kernel.org>
 <c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
 <20260615175535.5bc56cfc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm a user of AppleTalk and other "Retro"-Features in the Linux Kernel.

On 16 Jun 2026, at 2:55, Jakub Kicinski wrote:

> We can complain about the AI slop til the cows comes home.
> I don't like it, you don't like it. What difference does it make?
>
> If y'all have real solutions please share. Complaining about
> "commercial interests" and "nuk[ing] everything in a panic reaction"
> is not helpful.

the solution, as Adrian pointed out, is to leave these features in the Li=
nux kernel but have them disabled by default. Maybe put a warning message=
 in the kernel config tools that people should only enable these if they =
know what they are doing.

These "retro"-features should not pose any security risk of they are not =
compiled into a kernel.

Greetings

Carsten
