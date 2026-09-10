Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460C49F13A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050929; cv=none; b=Y03cUzAqaDAZX9IhAS6TaaUGOutjfomGyQFFuRYg9Cd7edr2nyaLiUMxMWfia0oxvuH8vvXWqf/Jd81vESEdragEOYdZrmpIyBCWy/95o99H99yRxBpnXK/fACDc4ex+v5bFwdyFQflz+UMD70jTNcWBDBQurcpjo/l5YPe9TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050929; c=relaxed/simple;
	bh=CyifzT447RQSMV7VQEiAP9hRqT8Nwx5VAaXNeXf/IyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gk9hMNfwA/AV5PG7zXeuh5qPG2ZlT5No395umr6F89zBHC5u3R6+wLfEFIENaNg04VxzXO3pP7fFy80ukq1FDnJpGSTqR8xMEwu9NV5AwBzzpLWv3+uoMYwY+7P6oa46Cc1Qh339ybrCJcOOFhTgU3GwmPa50smrgdGp9ahWMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GccFTWGZ; arc=none smtp.client-ip=74.125.231.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GccFTWGZ"
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-6bc93a7858fso178587eaf.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789050924; x=1789655724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCxyZZz6rPXR8L8h/M0W+Attud1AE0FTUv/300p7CEs=;
        b=GccFTWGZ4VTuDgeOAhWTn0va91qPrT2UuBETHKioePMyaRERdiA6ShklbVixAT50RV
         Wcc3gEGp2+z3c7paXDJwYg95xaSzW/MO1TTjWLUdUoCjYCXY2jwHwowOkIUPs++QJgSs
         HFMSFVEo3i999v3G6wQkgkvHNiFCc2qLI4QVeqpidC1QjLm3TpqSZtDJjSrizcqZqARi
         qyDGFyV2xZZlI5FB+hXVaaOQQFH35YQ+6NnxGMOoYeV7vvqC5pbY8hosfxuzwPebmNbQ
         nlIyfTzR61tRiJByMDNwI1AnAHPnwupS07M9uPX5zc+Ep1n5UayVkHiapXYDJFZhiOTU
         SxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050924; x=1789655724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HCxyZZz6rPXR8L8h/M0W+Attud1AE0FTUv/300p7CEs=;
        b=ErAZbM1qxJsyGk+O12kXchOXGBBZ89kzbI4DUQqFvXXcjskZQfrInO1CfoyxlCv6AN
         McY7XYnouWQmlnKapcUnzq05/6P1A9JeG+iqeWAjlphyAaKFyFJLKnHdFCyrBCiVru7a
         G4phoT46kuCHN4V7gyJ9o9rlAfu4jc4aBR5yRIXUZyNsj9ylJOBbl4+CSv5bT1g0UuTH
         cqX8VLEjmAl5OThF+Wu4NhgwIxsTGHUEH0CzYOpck6QfjOBoYFJpl+BO9icUEElwfSU8
         t4PoUOKHHtjMq2HSsYjjrgOZiKw1m/QdlZ1LR4zFou/qbcmgvRwmUICjhoksJaVUVClC
         mMfw==
X-Gm-Message-State: AFuF++nQlH6Pgpvu2+Sp9lbbLBPkKj0i3D1LUeADHzSRJyiFIniOkYY0
	F+8ULUXOJl5tuNp/0/BqF10fAZp7iwsF5ssIapGx+3aqCeFKfObBpINHq38xCiEY
X-Gm-Gg: AYBFou13Tpc+Q3RcRKwBAh2WIBa1BAVOIXUUO+Z4nMpyrcYezbPnUMRaxum7xPorquH
	KXRqzUHwEJXQXbJhi3z80z/QwU6CfoTs9Tp0+ml8t30ICcCkHEt946Xo8fdzfi7Alx2EFFEJoom
	mubb6e36FBUIRwFEAeYWu1vq3K3STX3KngbCdd+jO5wjd0xZOHgyUu8weyBryi/Joa2fJCGncvz
	KXffOfDFY6sZAISuPxvR7eh5L4Y2bi/LkTms2zZexHBlLLHn4p1b965lcqnxujfgQ0wrlppVKL5
	OSRDXeOXmCkICenNgZGBNK4E7eE2cAFBkF1B6yr641ijXssnTLPfBio6jOrT+N67X+Wc3NMh3lQ
	LYGncCnPMt2VHoF/TARF08Y7S1XGnaoi1AVvP4KdciigkA2mXQdZhq0XxBe0FKdBHq6CAKS2u/W
	P57DwCqsLP41SVTpkcmPgxFIeaWI+wFTsPdzwBEhFNeroflHCK5uGkpMw4E9dutIGMQDv8naKSO
	z/foZw6ttGsw8TbJ1kY/PLlrixfz931Niih5rLwbJ2VcXzLrM07R8TL8GOfnigVbrBBGiuxub5G
	vK1XYqLL4IZtcfOYZamE0UEoIGJvHvorP1QiexdtiuKQ/hMidGEoB5MQ7huCf0W2RU58+J8o8Nc
	b+Q==
X-Received: by 2002:a05:6820:3107:b0:6bf:5d5e:5403 with SMTP id 006d021491bc7-6bf5d5e6442mr2877845eaf.69.1789050924431;
        Thu, 10 Sep 2026 07:35:24 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm47718384c88.0.2026.09.10.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:35:24 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] drivers: net: smsc: Remove unused smc9194.h header
Date: Thu, 10 Sep 2026 07:35:05 -0700
Message-ID: <20260910143516.87304-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The smc9194 driver was removed in commit 9fdf9f61fa6d ("drivers: net:
smsc: smc9194: Remove this driver"), but smc9194.h was left behind.
Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/smsc/smc9194.h | 241 ----------------------------
 1 file changed, 241 deletions(-)
 delete mode 100644 drivers/net/ethernet/smsc/smc9194.h

diff --git a/drivers/net/ethernet/smsc/smc9194.h b/drivers/net/ethernet/smsc/smc9194.h
deleted file mode 100644
index cf69d0a5a1cb..000000000000
--- a/drivers/net/ethernet/smsc/smc9194.h
+++ /dev/null
@@ -1,241 +0,0 @@
-/*------------------------------------------------------------------------
- . smc9194.h
- . Copyright (C) 1996 by Erik Stahlman
- .
- . This software may be used and distributed according to the terms
- . of the GNU General Public License, incorporated herein by reference.
- .
- . This file contains register information and access macros for
- . the SMC91xxx chipset.
- .
- . Information contained in this file was obtained from the SMC91C94
- . manual from SMC.  To get a copy, if you really want one, you can find
- . information under www.smc.com in the components division.
- . ( this thanks to advice from Donald Becker ).
- .
- . Authors
- . 	Erik Stahlman				( erik@vt.edu )
- .
- . History
- . 01/06/96		 Erik Stahlman   moved definitions here from main .c file
- . 01/19/96		 Erik Stahlman	  polished this up some, and added better
- .										  error handling
- .
- ---------------------------------------------------------------------------*/
-#ifndef _SMC9194_H_
-#define _SMC9194_H_
-
-/* I want some simple types */
-
-typedef unsigned char			byte;
-typedef unsigned short			word;
-typedef unsigned long int 		dword;
-
-
-/* Because of bank switching, the SMC91xxx uses only 16 I/O ports */
-
-#define SMC_IO_EXTENT	16
-
-
-/*---------------------------------------------------------------
- .
- . A description of the SMC registers is probably in order here,
- . although for details, the SMC datasheet is invaluable.
- .
- . Basically, the chip has 4 banks of registers ( 0 to 3 ), which
- . are accessed by writing a number into the BANK_SELECT register
- . ( I also use a SMC_SELECT_BANK macro for this ).
- .
- . The banks are configured so that for most purposes, bank 2 is all
- . that is needed for simple run time tasks.
- -----------------------------------------------------------------------*/
-
-/*
- . Bank Select Register:
- .
- .		yyyy yyyy 0000 00xx
- .		xx 		= bank number
- .		yyyy yyyy	= 0x33, for identification purposes.
-*/
-#define	BANK_SELECT		14
-
-/* BANK 0  */
-
-#define	TCR 		0    	/* transmit control register */
-#define TCR_ENABLE	0x0001	/* if this is 1, we can transmit */
-#define TCR_FDUPLX    	0x0800  /* receive packets sent out */
-#define TCR_STP_SQET	0x1000	/* stop transmitting if Signal quality error */
-#define	TCR_MON_CNS	0x0400	/* monitors the carrier status */
-#define	TCR_PAD_ENABLE	0x0080	/* pads short packets to 64 bytes */
-
-#define	TCR_CLEAR	0	/* do NOTHING */
-/* the normal settings for the TCR register : */
-/* QUESTION: do I want to enable padding of short packets ? */
-#define	TCR_NORMAL  	TCR_ENABLE
-
-
-#define EPH_STATUS	2
-#define ES_LINK_OK	0x4000	/* is the link integrity ok ? */
-
-#define	RCR		4
-#define RCR_SOFTRESET	0x8000 	/* resets the chip */
-#define	RCR_STRIP_CRC	0x200	/* strips CRC */
-#define RCR_ENABLE	0x100	/* IFF this is set, we can receive packets */
-#define RCR_ALMUL	0x4 	/* receive all multicast packets */
-#define	RCR_PROMISC	0x2	/* enable promiscuous mode */
-
-/* the normal settings for the RCR register : */
-#define	RCR_NORMAL	(RCR_STRIP_CRC | RCR_ENABLE)
-#define RCR_CLEAR	0x0		/* set it to a base state */
-
-#define	COUNTER		6
-#define	MIR		8
-#define	MCR		10
-/* 12 is reserved */
-
-/* BANK 1 */
-#define CONFIG			0
-#define CFG_AUI_SELECT	 	0x100
-#define	BASE			2
-#define	ADDR0			4
-#define	ADDR1			6
-#define	ADDR2			8
-#define	GENERAL			10
-#define	CONTROL			12
-#define	CTL_POWERDOWN		0x2000
-#define	CTL_LE_ENABLE		0x80
-#define	CTL_CR_ENABLE		0x40
-#define	CTL_TE_ENABLE		0x0020
-#define CTL_AUTO_RELEASE	0x0800
-#define	CTL_EPROM_ACCESS	0x0003 /* high if Eprom is being read */
-
-/* BANK 2 */
-#define MMU_CMD		0
-#define MC_BUSY		1	/* only readable bit in the register */
-#define MC_NOP		0
-#define	MC_ALLOC	0x20  	/* or with number of 256 byte packets */
-#define	MC_RESET	0x40
-#define	MC_REMOVE	0x60  	/* remove the current rx packet */
-#define MC_RELEASE  	0x80  	/* remove and release the current rx packet */
-#define MC_FREEPKT  	0xA0  	/* Release packet in PNR register */
-#define MC_ENQUEUE	0xC0 	/* Enqueue the packet for transmit */
-
-#define	PNR_ARR		2
-#define FIFO_PORTS	4
-
-#define FP_RXEMPTY  0x8000
-#define FP_TXEMPTY  0x80
-
-#define	POINTER		6
-#define PTR_READ	0x2000
-#define	PTR_RCV		0x8000
-#define	PTR_AUTOINC 	0x4000
-#define PTR_AUTO_INC	0x0040
-
-#define	DATA_1		8
-#define	DATA_2		10
-#define	INTERRUPT	12
-
-#define INT_MASK	13
-#define IM_RCV_INT	0x1
-#define	IM_TX_INT	0x2
-#define	IM_TX_EMPTY_INT	0x4
-#define	IM_ALLOC_INT	0x8
-#define	IM_RX_OVRN_INT	0x10
-#define	IM_EPH_INT	0x20
-#define	IM_ERCV_INT	0x40 /* not on SMC9192 */
-
-/* BANK 3 */
-#define	MULTICAST1	0
-#define	MULTICAST2	2
-#define	MULTICAST3	4
-#define	MULTICAST4	6
-#define	MGMT		8
-#define	REVISION	10 /* ( hi: chip id   low: rev # ) */
-
-
-/* this is NOT on SMC9192 */
-#define	ERCV		12
-
-#define CHIP_9190	3
-#define CHIP_9194	4
-#define CHIP_9195	5
-#define CHIP_91100	7
-
-static const char * chip_ids[ 15 ] =  {
-	NULL, NULL, NULL,
-	/* 3 */ "SMC91C90/91C92",
-	/* 4 */ "SMC91C94",
-	/* 5 */ "SMC91C95",
-	NULL,
-	/* 7 */ "SMC91C100",
-	/* 8 */ "SMC91C100FD",
-	NULL, NULL, NULL,
-	NULL, NULL, NULL};
-
-/*
- . Transmit status bits
-*/
-#define TS_SUCCESS 0x0001
-#define TS_LOSTCAR 0x0400
-#define TS_LATCOL  0x0200
-#define TS_16COL   0x0010
-
-/*
- . Receive status bits
-*/
-#define RS_ALGNERR	0x8000
-#define RS_BADCRC	0x2000
-#define RS_ODDFRAME	0x1000
-#define RS_TOOLONG	0x0800
-#define RS_TOOSHORT	0x0400
-#define RS_MULTICAST	0x0001
-#define RS_ERRORS	(RS_ALGNERR | RS_BADCRC | RS_TOOLONG | RS_TOOSHORT)
-
-static const char * interfaces[ 2 ] = { "TP", "AUI" };
-
-/*-------------------------------------------------------------------------
- .  I define some macros to make it easier to do somewhat common
- . or slightly complicated, repeated tasks.
- --------------------------------------------------------------------------*/
-
-/* select a register bank, 0 to 3  */
-
-#define SMC_SELECT_BANK(x)  { outw( x, ioaddr + BANK_SELECT ); }
-
-/* define a small delay for the reset */
-#define SMC_DELAY() { inw( ioaddr + RCR );\
-			inw( ioaddr + RCR );\
-			inw( ioaddr + RCR );  }
-
-/* this enables an interrupt in the interrupt mask register */
-#define SMC_ENABLE_INT(x) {\
-		unsigned char mask;\
-		SMC_SELECT_BANK(2);\
-		mask = inb( ioaddr + INT_MASK );\
-		mask |= (x);\
-		outb( mask, ioaddr + INT_MASK ); \
-}
-
-/* this disables an interrupt from the interrupt mask register */
-
-#define SMC_DISABLE_INT(x) {\
-		unsigned char mask;\
-		SMC_SELECT_BANK(2);\
-		mask = inb( ioaddr + INT_MASK );\
-		mask &= ~(x);\
-		outb( mask, ioaddr + INT_MASK ); \
-}
-
-/*----------------------------------------------------------------------
- . Define the interrupts that I want to receive from the card
- .
- . I want:
- .  IM_EPH_INT, for nasty errors
- .  IM_RCV_INT, for happy received packets
- .  IM_RX_OVRN_INT, because I have to kick the receiver
- --------------------------------------------------------------------------*/
-#define SMC_INTERRUPT_MASK   (IM_EPH_INT | IM_RX_OVRN_INT | IM_RCV_INT)
-
-#endif  /* _SMC_9194_H_ */
-
-- 
2.43.0

