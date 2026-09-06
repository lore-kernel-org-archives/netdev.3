Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F332D0EE
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716809; cv=none; b=pAGIKEhBG37kSSh9DqxjQ4Sf37xRQy1rrDZ1NiyJkTr6mcwkdhqmKxctBeeTkLAwY/W4Q3lvbXk4R1R9zdmZQQ5PsOiTBJWpM+vmIDT3BmGlbvPPDTyUefFiqj1edAnc0bTzW4VCPs+01KVsdpgzopFbecRbf3bct7L3npOjeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716809; c=relaxed/simple;
	bh=EYGVj3mzKUq80i3j8waQBTAvpmCGmA3nzBgbasx1YKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faspYMCiE9CYjBU2DNs11XdvbL+x66RFXBWNgUHB7ef7nvjSGp7rRc3TiIXo6qlM0qsxLAX5w1XlCxS5/oFzH69hf9vr/PhePYRcfJCCbX2NtxhFGi5tKHsx9IMJJGEw/P2fcj/T363aQGHJQ3MSbw2A4fC5vc8vkvL1eJWAXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=H0nnbyDX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="H0nnbyDX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso34904065e9.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788716806; x=1789321606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=720RRbxnS3HvGpcM/W7v6mXltwXRIlGuHc+X9QUEoF4=;
        b=H0nnbyDXKGAy/UNR9CHvhq+/z0Y4ZeCk/msYPW7VuYWh3fknV6SAzoMR30WRFjiqeW
         PifFmynOxU9QOdUYQiu8+DqeVfoqCqKpJgSyhGMLcdcdsyLS95A7Urp5r3R8EVRWB9TW
         9F3Oq/el/RF2UrRcd2MP9Z0nsMoP6XN1avFKMByHTf2QEK45O7MbeRUJenDH3cfANAVg
         BpgsBKM8rCIZJfEn86ygPjQDEKelEzEhpszOnJLZxIISBvgCxdbkwJLoULf3go35nSY3
         CrWB5JLjt4qxMbjwOVYC7BEYoPoHohmPr1RHNGnF9ixBzc8nFl4+RBTL+NYD0GhPDxSv
         9H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716806; x=1789321606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=720RRbxnS3HvGpcM/W7v6mXltwXRIlGuHc+X9QUEoF4=;
        b=QuobatY+CHs61LoI+Yipp65iAFOmBSBfJUrqjQrDZaCr1LVjNkE411Wi9ELknxiZu0
         Qik/GYooMuKxoscMTLh5Kpy/HwTkpO1EMfyfsjGx/ThqNyjSF8DnCAY5choGHwGHe1d0
         hbrQLW+eiASVUMNH8XtrDpeK9OXRGjgBaNe9FVnINAWQjEqph1GQ7ICrfOLJMiRhfIdg
         WFifibD5Vk9XE0wVXCKXIl1D2wZhId5YrrewqaNxUjHczmXeAkkEYpWzItb3wZutUZ+0
         eW3zpPJWKQFMNNpS0A02MND/AOjLuo119SslRjteXUn4e9X0NC21bRpiDe6qupOe8AUO
         PP9w==
X-Forwarded-Encrypted: i=1; AKwUvByeLctt0Z82oV4m+TWcUox2Qigntc5fiiRrfwAAnsixdhNvtlzjSh3Tu9InhkW/atflXz9lN+8=@vger.kernel.org
X-Gm-Message-State: AFuF++kFDkXuKf1BmaJ11ioniF1cE/UZYKWxOjPGMDeo8SeYDIJ9yzi8
	XI5KNL1+xHGywaYt+QR77mqvfjZIZPLB7Z5Zays7CumK99WNUpOtZ3U+7TsRjDag0Vf/ddRhppv
	rn3ngoiO+pmMd0Sg=
X-Gm-Gg: AYBFou1wGTb2tTkLkUjTIagjp2TsBIp9H8E1QMqOI0RcHS+pkdaakvi4Y1sMnAuWIGV
	OzTo1I7ECO4balHVatgZWR0wSQavuHGzKkIy512qzGa4FZdkT11L+ghiu6+Cn+tqYZyY5CqtByB
	MOeMrEdFTXGFvn9XluPVXH461R0yRuh9x4W9gzdgZkMtnojTrte8390PYufbtrdsPBImHop7mls
	k6B/bWzmEL63eRZbE12E1T/kY9wRBrNl4xrmdK9ZScLa8JbsZWvXWoaigtoDlp8V9nq1DZy5M2j
	UOmaZrcG0jgK2gn7Dkb3sw6gSlBXXn28M3DgdBQZHAm/j4gK3iWcaCbaBInfe3KtonS946Rz6F4
	bNyU65+ppi1GGhYFzWGmT4OHaUuZHuR0XAPAf8X63xiB8HQI4ffNKM0TmPkNt7AFncV6yjr8LsT
	jTMfdwN8/x5VOjqDEWnW8U/aDMZ58U4LahtCmZbNs=
X-Received: by 2002:a05:600c:198d:b0:49d:34:420d with SMTP id 5b1f17b1804b1-49d00344222mr121092515e9.20.1788716805593;
        Sun, 06 Sep 2026 10:46:45 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm331552855e9.12.2026.09.06.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:46:45 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/2] net: fix a stale phylink PHY pointer and a lost PHY interrupt
Date: Sun,  6 Sep 2026 17:46:41 +0000
Message-ID: <20260906174643.4107607-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent fixes, both found while chasing a PHY whose driver is a
module on a rootfs that is not mounted yet when a DSA switch probes.
Neither one depends on that setup, and neither depends on the other.

Patch 1: phylink_bringup_phy() records the PHY in pl->phydev before its
last fallible step, so a failure there leaves a pointer to a PHY the
caller has already detached. A later phylink_disconnect_phy() detaches
it a second time and drops references the first detach already
released.

Patch 2: a PHY that binds a driver with no interrupt callbacks loses
the interrupt number the firmware node declared. The specific driver
that binds afterwards never sees it, and unless its consumer installs
one itself the PHY is polled from then on.

Patch 2 takes a different approach from v4 and does not carry Andrew's
Reviewed-by, which I asked him to hold [2]. v4 read the number back
from bus->irq[]. The Sashiko bot pointed out that a bus installing the
interrupt only on the phy_device never writes that table, and it is
right: on smsc95xx and lan78xx the restore read PHY_POLL back out and
did nothing. v5 saves the number where phy_probe() takes it, so the
source cannot be a table that never held it, and nothing has to guess
whether a PHY_POLL came from the bind.

Two neighbouring problems are deliberately left alone:

 - phy_attach_direct() clobbers the interrupt a second time, at the
   attach rather than at the bind, and that loses a number a consumer
   installed after probe. It is phylib's own rule about a driver
   without interrupt callbacks, not the PHY_F_NO_IRQ line above it, and
   it is re-applied on every attach, so undoing it is a different
   change with a different owner.
 - phy_remove() leaves phydev->drv NULL while a consumer can still hold
   the PHY, and phy_disconnect() dereferences it through
   phy_config_interrupt(). That is reachable today for a PHY that has
   an interrupt number and a driver that supports interrupts. Patch 2
   refuses to restore while a consumer holds the PHY, so it does not
   hand a number back to a PHY that phy_probe() had put in polling
   mode, and does not widen that path.

The Fixes tag reaches 2005, but the guard leans on phy_detach() clearing
phy_link_change, which is only true since commit e0d1c55501d3 ("net:
phy: fix phy_uses_state_machine()") in v6.17. Older trees never clear
the mark, so the restore would be refused forever and the patch would be
a silent no-op there. Patch 2 says so in its own message, since that is
what travels into a backport. Those trees also lack the is_genphy_driven
context the unwind hunk needs, so the patch will not apply to them
unaided in any case.

One case the patch does not cover, for the same reason. Unbind a driver
through sysfs while a consumer holds the PHY and the restore is
refused, correctly; the consumer's later detach clears the mark but
reaches no second remove, so the number waits in irq_saved and the next
driver to bind still starts polled. It comes back at that driver's
remove. Closing it would mean restoring from phy_detach() again, which
is the shape this version exists to leave behind.

No hardware measurement of the restore is offered, and the reason is
worth stating rather than hiding. The cycle this fixes needs a generic
driver bound at the PHY before the specific one - which needs the
specific driver or its firmware to be unreadable when the MDIO bus is
scanned. The board I develop on cannot produce that: its rootfs and
firmware are present at boot, so the specific driver binds directly and
the generic one never probes. phydev->irq has no observable outside the
phy_attached_info() line, and that needs a consumer to attach, which on
this board only ever meets the specific driver. So the three restore
sites are argued from the code, not run: phy_remove(), reached from a
sysfs unbind and from phy_detach(); phy_probe()'s own error exit, which
the driver core does not follow with a remove; and phy_attach_direct()'s
unwind of a generic bind that failed after probe, where
device_bind_driver() fails only in driver_sysfs_add().

[2] https://lore.kernel.org/netdev/20260905000722.422652-1-f@lex.la/

Changes in v5:
 - patch 2 changes approach: the number is saved in phy_probe() where
   it is taken and restored in phy_remove() and on phy_probe()'s own
   error exit, rather than read back from bus->irq[] in phy_detach()
 - patch 2: a generic bind that fails after its probe succeeded is a
   third exit with no restore, so phy_attach_direct()'s unwind gets one
   too, as it did in v4
 - patch 2: the restore is refused while a consumer holds the PHY, so
   an unbind or an rmmod under a live consumer cannot hand a number
   back to a phy_disconnect() that never requested one. The mark is
   phy_link_change rather than attached_dev, because a DSA shared port
   attaches its PHY with no netdev and leaves attached_dev NULL
 - patch 1 is unchanged apart from the Assisted-by trailer, which it
   should have carried from the start
 - v4: https://lore.kernel.org/netdev/20260902080511.2211261-1-f@lex.la/

Aleksei Sviridkin (2):
  net: phylink: unwind the PHY binding when bringup fails late
  net: phy: restore the interrupt phy_probe() replaced with PHY_POLL

 drivers/net/phy/phy_device.c | 23 ++++++++++++++++++++++-
 drivers/net/phy/phylink.c    | 29 ++++++++++++++++++++---------
 include/linux/phy.h          |  3 +++
 3 files changed, 45 insertions(+), 10 deletions(-)


base-commit: 6262acad9db197b5ed12e3b245d2e6d0c80fb960
-- 
2.53.0

