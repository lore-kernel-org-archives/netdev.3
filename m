Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C0A1F19A
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769389499; cv=none; b=KN9uoyAF/551rbzkSARSx+sn6JQC1tPN1EhiCH8WljVrMjCkitl1L7BOwSLySbseaWNwgunyq7/8NEGYKPKfcuAa18hpqC5vK15uCFY6oJe3V4JGfmPUclZt/v9KzIpjdgjutPbPXmT8Bd8u8xeBR4+Rhmzxi/jtlXlWqcNbcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769389499; c=relaxed/simple;
	bh=CVGx4Llh8HKTcUZI8eq2U6Ypba76dI5eactbGMHyBRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OsvXFi+imBJz9cVoWqejuDsumEVfWWbRb3sgvjvYUoLek3VdXx7s4RjMfx/Q9zS/m7bX6VBHnIV5VgSD7n5iNE01RWqK4NU/eRn3Szn832+ejjJjvKicrx0pPC07J5yPIJgAhxiVl3vRERb/NT6MQk9Q/nCYvnUD8JwZ4/zd/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 436FE92009C; Mon, 26 Jan 2026 02:04:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3D0E892009B;
	Mon, 26 Jan 2026 01:04:49 +0000 (GMT)
Date: Mon, 26 Jan 2026 01:04:49 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew@lunn.ch>
cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
    Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] docs: 3c509: remove note about card detection
 failing with overclock
In-Reply-To: <5e52ea32-a79f-40f3-a62d-4a8af6162934@lunn.ch>
Message-ID: <alpine.DEB.2.21.2601260039220.40317@angie.orcam.me.uk>
References: <20260107071146.30083-1-enelsonmoore@gmail.com> <20260109180147.GN345651@kernel.org> <CADkSEUjEobNfmnq1vZz5mr7rDs6hN43LeOk1UJ5gWW_jFFHhaQ@mail.gmail.com> <5e52ea32-a79f-40f3-a62d-4a8af6162934@lunn.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 25 Jan 2026, Andrew Lunn wrote:

> > > In any case, I think it would be worth providing a reference
> > > to the commit where this was fixed.
> > I just checked with git blame and all of the mdelay/udelay references
> > in the driver predate Git history.
> 
> For commits before the beginning of git, we just use the first commit
> in git.

 As an active user of the driver I did some digging and tracked it down to 
Linux 2.1.100, where we have this (among others):

diff -u --recursive --new-file v2.1.99/linux/drivers/net/3c509.c linux/drivers/net/3c509.c
--- v2.1.99/linux/drivers/net/3c509.c	Mon Feb 23 18:12:05 1998
+++ linux/drivers/net/3c509.c	Thu May  7 14:40:41 1998
@@ -27,10 +27,22 @@
 	FIXES:
 		Alan Cox:       Removed the 'Unexpected interrupt' bug.
 		Michael Meskes:	Upgraded to Donald Becker's version 1.07.
-		Phil Blundell:  Media selection support.
+		Alan Cox:	Increased the eeprom delay. Regardless of 
+				what the docs say some people definitely
+				get problems with lower (but in card spec)
+				delays
+		v1.10 4/21/97 Fixed module code so that multiple cards may be detected,
+				other cleanups.  -djb
+		Andrea Arcangeli:	Upgraded to Donald Becker's version 1.12.
 */
[...] 
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
  */
-__initfunc(static ushort read_eeprom(short ioaddr, int index))
+static ushort read_eeprom(short ioaddr, int index)
 {
 	outw(EEPROM_READ + index, ioaddr + 10);
 	/* Pause for at least 162 us. for the read to take place. */
-	udelay (300);
+	udelay (500);
 	return inw(ioaddr + 12);
 }
 
 /* Read a word from the EEPROM when in the ISA ID probe state. */
-__initfunc(static ushort id_read_eeprom(int index))
+static ushort id_read_eeprom(int index)
 {
 	int bit, word = 0;
 
@@ -340,8 +340,8 @@
 	outb(EEPROM_READ + index, id_port);
 
 	/* Pause for at least 162 us. for the read to take place. */
-	udelay (300);
-
+	udelay (500);
+	
 	for (bit = 15; bit >= 0; bit--)
 		word = (word << 1) + (inb(id_port) & 0x01);
 
-- so it's not about using a time-based vs some other kind of delay.  The 
comment to be removed was only added along with the whole document on the 
3c509 driver with Linux 2.5.13, much later (2002 vs 1998), and therefore 
still stands.

 NAK for the change then.  Where has the idea to drop this comment come 
from anyway?

  Maciej
