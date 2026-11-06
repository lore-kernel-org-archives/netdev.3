Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934376;
	b=n0f8sNlGpWBoB/Spp7WCm8p29jLsFDB7Sf0+GCfspp8f1TXDh6ESLJ7De+35xYxKi+Q5
	 a7PV5duKPtRY63VDY3AzOihUh+aZByyENtbVMObAURESJ+6taJ/WdntteGYP06p7fi8nb
	 8QIBYcbvpUa+PlawMeA4JmCYbYXFGLRyBabtTGlywaTHIEa8rXB2vBqrtsuqjt0NLHReC
	 zi63ewF0qFw27uTUIo9VqqKqOl91s4gOj3ZshTqQEAO0u/1caLC5WCLibVLdYRiqxvHje
	 GE0jKZNVaadIrd/Rfy9/GJPrws1jXjOapkg8NwkWeOjD7l5s5/dJ8/4tANHny+TrLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934376;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fZRGhGh2wo9CgPnPSQogQeQdxcyl7JS3LITESfEWy7s=;
	b=PcrFAW6+rBWWXT7OcFLWO4WOP3rJ0Pr4VoDFcepRPd+5kaLQeERlIoZIgp9X2vQ9idGE
	 BlpF/PTRKzGmZ8FTJW6IFx+3axr4NMuMeP/CoPCVHK2HYMqlRrKEypzfSW0OFmZ7KX0iy
	 MQ7TF89EMS869gWQQYaC1QHdYto29/8n502BV5SOGBGR6DfgerGoAFNUy9bRKvgyV0Mjm
	 5+owxjV5HiXwKglbPHa3UmLk9NFp+Yb/+vFHwGGO03avy5PLyhVhhSzxYEfxiUOKy5nn5
	 tddb1aKtdCKmfeWhqPCUTf4l6KyrxiPYq2VoxP91OZeQMa4Y4R8ZV8TLbHGmwDNhk+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="htXxw/8u";
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BA606A332;
	Fri,  6 Nov 2026 03:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B71BA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=htXxw/8u
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793934365; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fZRGhGh2wo9CgPnPSQogQeQdxcyl7JS3LITESfEWy7s=;
	b=htXxw/8u6oNFapDwVuP2YAe9M1USuuTCCRTvgzz3opSrVTifjm7feEVSQ2ma7VbF6cr06wcjBGufX+pJ3gx7xunpmE0x8E4a3I2GVHDLpn3dr6hsFAY3dKoFAf6e+4Br5evUfQ2qghxj3L98pget6N1z6JElDQI0ZtL8i0XvBIc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438125|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00621838-0.000511926-0.99327;FP=5330561223211519360|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jxwxsgp_1793934362;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jxwxsgp_1793934362 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 11:06:03 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	khtsai@google.com,
	fangxy@xiaopeng.com,
	Randy Dunlap <rdunlap@infradead.org>,
	dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr
Date: Fri,  6 Nov 2026 11:06:01 +0800
Message-ID: <20261106030601.575459-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <auxy5cmALpy0AMzu@ashevche-desk.local>
References: <20261105072147.3383565-1-liuc63@xiaopeng.com> <20261105072147.3383565-3-liuc63@xiaopeng.com> <auxy5cmALpy0AMzu@ashevche-desk.local>
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

Hi Andy,

Thanks for the review and for the Reviewed-by. v4 goes out together with
this mail.

On Thu, Nov 05, 2026 at 02:13:25PM +0200, Andy Shevchenko wrote:
> It is worth to mention that the occurrences of use those formats
> (Cisco and irregular grouping) are more historical and rare to meet
> these days.  Also point out that the original commit didn't explain
> the choice of implementation, most likely it was just for
> simplification and not really allowing non-standard formats to be
> used.

v4 adds a paragraph right after the one that says what stops working:

	Neither of the two should be missed: they are historical
	notations that are rarely met these days, and the commit that
	introduced the loop never said that it accepted them.  That
	commit only explains that it resolves a FIXME by adding module
	parameters for stable addresses, so skipping a delimiter
	wherever one happens to turn up reads as a simplification of
	the parser rather than as support for non-standard formats.

I checked the second half instead of taking it on trust. The log of
331a2d82bcaf has no hit for format, colon, separator, delimiter, hex,
notation, cisco, dot or parse. All it says is that it closes a FIXME by
giving the gadget stable addresses through module parameters.

> As I pointed out, you may use the correct SHA, but you need to point
> the readers out to the history.git tree.

With the history.git pointer from your other mail [1] it does resolve,
and what I wrote back to you was wrong: "cgit returns 404" only holds
for torvalds/linux.git, whose root is 1da177e4c3f4. history.git expands
the short sha to 331a2d82bcaff97ecc4764cca266db0d7465b937, David
Brownell, 2004-05-17, committed by Greg KH, adding get_ether_addr() to
drivers/usb/gadget/ether.c with the loop already in its final shape,
nibble() where we now have hex_to_bin().

v4 names it in the free form you described in the v2 thread:

	The loop is older than the git history.  It was introduced by
	331a2d82bcaf ("[PATCH] USB: ethernet/rndis gadget address
	params") from v2.6.7 in drivers/usb/gadget/ether.c, and commit
	2b3d942c4878 ("usb ethernet gadget: split out network core")
	copied it into u_ether.c.  331a2d82bcaf predates the git
	conversion and only resolves in the historic tree history.git,
	so a Fixes: tag naming it would not resolve for most readers
	and is left out.

One correction on the release, though: it is v2.6.7, not v2.6.10-rc1. In
the history.git log of drivers/usb/gadget/ether.c the commit is absent
at v2.6.6 (20 entries) and present at v2.6.7-rc1 (22 entries), where it
is the newest commit on that file, dated 2004-05-17, ahead of v2.6.7 of
2004-06-03. It is of course still there at v2.6.10-rc1 (39 entries),
which is where I would guess the later tag came from.

> Code wise LGTM, so after addressing the commit message and reference
> to the culprit commit, feel free to add
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> (with all awareness of the potential weirdness of the user input)

Added to 2/2, after Signed-off-by. 1/2 already carried it from v3 and is
otherwise unchanged. v4 is message only: the tree of 2/2 is byte
identical to what you reviewed, only the log changed.

Your other mail [1] also has this:

> Cisco should not work, the index is going over 3 characters on each
> iteration.

It does work in the old loop, and I verified that with the verbatim code
rather than by reading it. The loop advances two characters per
iteration, not three, and skips a delimiter only when one sits at the
start of an iteration:

	for (i = 0; i < 6; i++) {
		if ((*str == '.') || (*str == ':'))
			str++;
		num = hex_to_bin(*str++) << 4;
		num |= hex_to_bin(*str++);
		dev_addr[i] = num;
	}

A Cisco group is exactly four digits, so both dots land at the start of
an iteration and are skipped. Tracing "aabb.ccdd.eeff":

	i=0 pos= 0 skip=0 "aab" -> aa
	i=1 pos= 2 skip=0 "bb." -> bb
	i=2 pos= 4 skip=1 ".cc" -> cc
	i=3 pos= 7 skip=0 "dd." -> dd
	i=4 pos= 9 skip=1 ".ee" -> ee
	i=5 pos=12 skip=0 "ff"  -> ff

All 14 characters are consumed and the result is aa:bb:cc:dd:ee:ff, so
the old code did accept the notation. That is why the v3 log lists it as
something that stops working.

The fixed three character stride belongs to parse_mac_pton(), which
looks at s[i*3], s[i*3+1] and s[i*3+2] and wants a delimiter at the last
of those. There Cisco is rejected, because position 2 holds 'b', and
that rejection is exactly the narrowing the v4 log records.

[1] https://lore.kernel.org/all/auw8sAYE-nkZ-qIT@ashevche-desk.local/

Liu Chao
