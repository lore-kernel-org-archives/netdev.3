Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333202;
	b=aFMm2l7UrSDNeG2JUJr7p7+bEJS9HxcxHDTDck94EigIBCT/j1RzWsZVN7hexkF6MBza
	 R8R07ry0hvmQHDMjNLkAxoIXBCdkjn9PMg0oCON/v//B4eW1a6VcNSVaUjLsENQVD6oV1
	 UKcLT3dKz2jda+zcPmdYG29CCbURyaDxLDh+ICAZ345yXPqycCnnTAPidkfY/3EPFZ2Lf
	 QGizSR4+ASJqo0yoUswLHp/GnXgSzBhXwaYJqWhkWwW2Yt5VzRZCu0jyO8cYfKhjnjtxh
	 nR4nNwGZsRQ9DnQyN+wlgWPmPYTKFtk+plWkEUheyLAr551gd6wVw2XEPz/70BPiKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=idK/OHsk8PCTskL28fTb65exOFJHBkY2hYQtf1j8B4w=;
	b=TrCNNX9Aq+M1Hrc6LG3k86abI48IgtrRX6V+ZM82swOuhQwFITQGyYvfWeclKedZOIgM
	 oadJEcgDvlfpZptvBMdm4E5eBrjZokCNoNnaiTn1fpIcaXFAwFFoNL6mfRKcUJnZ7xO3o
	 Ue2v/ClEJiPhrgrKvgjtKqP6ic0+UZVypBknafF2N8Wkn1MDnb46CKzgqUNx4KROsFNgk
	 Omg8gSIWho2aNdp7yTUw6OVwry+iO+bZ2+KAKQ2k3rOd/BQmbFflDGRtMg2Vt/Fa4ozCp
	 2KnsFrUj79++8AHnpZwu2ADV59TLBVpa2y0C2VIJjGafjiMFAGY0p6rc2Q5ZSckq3jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HdgpzyW;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48A606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E48A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HdgpzyW
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso701739eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793333201; x=1793938001; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idK/OHsk8PCTskL28fTb65exOFJHBkY2hYQtf1j8B4w=;
        b=0HdgpzyWMzAaoPAZLrtT2XHCPIqQb3vM4JPk54LSiMC6tIWml53jr1UhLQ1QFeBjX5
         /Ny8K2v7jsRgyPq9BS4f6ivJUECaM1xN+0m9vzWVRILjFl4PqtHWGc9TYJQGJgEd85Tm
         mfCd3EvznNT4sRQyWVtbNk8IxrmiR29ayCxuPa0u2vFxUuaX2GK/ZU08qkbdKs1PTwRs
         DNb+rFIi5b9YGb0tr+hELJNPs7j+AHnivq9/avfW50qjIYBhZCZ+F6lVLgbdPeplb8T9
         nzW1Kb4isSli+EPSqvEvHY+ohd21as7QjwZv0r4AHV4nlL9CogthY0cHjQn+2pfMW89L
         9YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333201; x=1793938001;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idK/OHsk8PCTskL28fTb65exOFJHBkY2hYQtf1j8B4w=;
        b=mnOE+z2U+//FxTvFVKFbucYvX765ApcjQmxIgqqdxDw6DDhYk/kTeFOAw4oxxxfNh4
         uDmMtEnnNuBgl1NiEyw+zgjHTpO4os6tRirNZ8WJdovhNkDZJKsJqgvLkztlyUCt4lhK
         E3Jx6NdCPTmW/msNAA6GNe6ElIp5+FF64hPA8IYV48kC3u+gRX9R3P0W/shnPbb47sa/
         dXUJc1ktqHESJ4wfwYDCVIA3z+4TpvggHGB7f1nI3Z/CfcFw4dn3Xqdhr5bWuzrYHxu5
         o8HfWuI/J2x7IyDvZNp2O+usvn/lXXjnnw6LRGFXh+R8biN1GeYBd3EvKmBArq9njnKG
         kG8Q==
X-Forwarded-Encrypted: i=1; AKwUvBy0UQbDqZ5zN4jxAJnk8WGha19GXBnZzHWnifBrR2A+9jhTBSN9Cg+AjS/v2Nc8lZ+/VWgbkaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQf/Sr0pnyj6/8EKU4fklzD92oLPoXNRZoScZfMxZIlhxJNP7k
	BL00uFaLN5qLALIbbAEsI33XqnHJWJvTgVJtzp7iIktC7PW1CgqO844n
X-Gm-Gg: AYBFou06sSeCH+yKF8++uzhRgUDuPvdfLMtWxoUJxMTpfC7UjfG2H9PWybrrnzsTExW
	3vsX5Ga9N4IN7SgOea2bYLWYS4OVXm9wBTkpDvdD3b7f0igRditV238toD07wwhEi3u0jVgdBO2
	EIp+s9fZOb5FpWU4Zz69nyS0qWUaqWLnQZsvKPqPuVEjKvoa+wrMpVC8HAnEtu/QJGwTCJNDfAu
	wD8seRQ+WohEXs2J80AaHFCRXsrSBfc4CvupAoJiTcjj1mu7O/l7oSId1Rn7Cvy7MnxHlDwcGSP
	kzU/5jcz/Ch1pvyTs6my3TRGdm3Gydh55liW6RvjtqQoin8xnipZwYl996GrwHYHGADaHoqU8kO
	yEqqF4AotnUGRs400ESLRZKBR8ZIVuiU5YYP66S6HTtNk6pkLtaIubcWgBwbpdzUK/LrdqlaD9d
	dCPNX5O54lFfvejH7slC9HIrVEVS/TFICQtDZ7lB9+23G+X58jTtiMoe9lvjVBYOnSRyUz9Nf5C
	g1SmFYm/rSbYRuHhwoBJX1Ck0GBzzSc1e3vYGcMaq5aPhsPW+XpUY+R/nCbRWEWsNv7p6JoRwA+
	EjSjQST0EunI1E5V/dnvU8iIAKImHnLniM2IA63Fk71EDCgU73006Q==
X-Received: by 2002:a05:7301:db8b:b0:35e:ebb1:8e5a with SMTP id 5a478bee46e88-36a424261e9mr1794192eec.26.1793333200901;
        Thu, 29 Oct 2026 21:06:40 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm3412216eec.11.2026.10.29.21.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:06:40 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: bridge: disable MRP ports before the FDB flush in
 del_nbp()
Date: Thu, 29 Oct 2026 21:06:18 -0700
Message-ID: <179333317814.2102764.8780283783548366593@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

net: bridge: disable MRP ports before the FDB flush in del_nbp()

del_nbp() flushes the port's FDB entries before it unregisters the RX
handler.  For a normal port, br_stp_disable_port() has already moved the
port to BR_STATE_DISABLED, so no frame is learned in between.

That does not hold for an MRP ring port.  br_set_state() ignores state
changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
the port state alone, and br_mrp_port_del() then sets the port to
BR_STATE_FORWARDING (when the bridge is up) before clearing the bit.  A
frame received between br_fdb_delete_by_port() and
netdev_rx_handler_unregister() is learned with dst == p.  Nothing
removes that entry before destroy_nbp_rcu() frees the port, and a later
frame to the learned MAC is forwarded to the freed port:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8 at addr ffff8880200bf038 by task mrp-poc/9420
  Call Trace:
   <IRQ>
   br_forward+0x55/0x3c0
   br_handle_frame_finish+0x1300/0x1d40
   br_handle_frame+0x90a/0x15c0

Remove the MRP and CFM instances before disabling the port, so that
br_stp_disable_port() actually transitions the port to BR_STATE_DISABLED.
The synchronize_net() in nbp_vlan_flush() then drains the receive paths
that could still learn with the old state, and the FDB flush that
follows removes their entries.  No frame can be learned after that
flush and before netdev_rx_handler_unregister().

Tested on v7.3 with KASAN and a reproducer that holds del_nbp() in the
post-FDB-flush/pre-unregister window for 1.5 s while a flood keeps
sending frames.  The unpatched kernel reports the KASAN use-after-free
above.  With this change the same window is exercised in six cycles and
no KASAN report is produced; normal bridge forwarding, FDB learning and
port detach also pass.

Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

v2:
- Implement the reorder suggested by Ido instead of adding a second FDB
  flush after netdev_rx_handler_unregister().
- The reproducer still exercises the post-flush window; the unpatched
  kernel reports the KASAN use-after-free and the patched kernel does
  not.
- Regression-tested normal bridge forwarding, FDB learning and port
  detach.

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..45642b6a5866 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -340,13 +340,13 @@ static void del_nbp(struct net_bridge_port *p)
 
 	nbp_delete_promisc(p);
 
+	br_mrp_port_del(br, p);
+	br_cfm_port_del(br, p);
+
 	spin_lock_bh(&br->lock);
 	br_stp_disable_port(p);
 	spin_unlock_bh(&br->lock);
 
-	br_mrp_port_del(br, p);
-	br_cfm_port_del(br, p);
-
 	br_ifinfo_notify(RTM_DELLINK, NULL, p);
 
 	list_del_rcu(&p->list);
