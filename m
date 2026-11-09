Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253733;
	b=ePeCt6JNA5q4YORDS1/wRRRmMXnaqTwx9ZdORxhmFeui73McmUQT+Ac+Z1fdMO5zZ9kZ
	 VY+7g8r1RAkjfXySVYSo+zaZXvohvMXnKSJpsY5zUzCIU/UIz5xYDIBnZtDk4FQM/Ahou
	 PwrfITBSRg18cR7a5aZYq3S22OXIrBRv0EFqbH7agrC/YQRJKJkpORn1TYfc0HHqbDID0
	 OMYebTM/Hxi8xBP+Xi8jMgN62kYAMdF/pxIs+nFbVSt+eNCFPgVj4pHFC3z1KjivMQbDu
	 HGtMkVaVERxPTy0Wsu/Kw22vnTpj1KsecZi9zOoWJTRU+mZwHy5ns1AfurGdSKUA77w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Eyd9veasL+1zYHn5ojY0wOfd1QwDacZa46cZ6SG2zHg=;
	b=spRy6jbbtvHurG3a2Z90MTazgzVfvHPzWAnXKivKdfIh5LyGxcroy2dCmrinjSJv6HK2
	 AVLpEYrPwB1CwTxOzI6BjPiz6ziqSBiRjIZ6vOmjCV+q3jLC94GOUe7wBDJYLLhMaNYUe
	 nHytj1WVGxaiXTRsgvrLVrP9oktEv4+gK3kcUDSsdyorEEsb64LxNIRkd7QXRDSXmgctR
	 2LZ50iQnU9XiUEGe96O2KQ88sAjR2RM3C3OaQOrXsiI23S1uxmDeJBOMi2/l4O8f7B63U
	 NWpt4JyqLLUI6OGI5yTQL2+Be/f4+nAaf1hHuqCsPRNiR5/pK/ID7sDF8O1ITA5e4rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaJTdBmy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C160A2607
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaJTdBmy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE061F008AB;
	Mon,  9 Nov 2026 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253732;
	bh=Eyd9veasL+1zYHn5ojY0wOfd1QwDacZa46cZ6SG2zHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaJTdBmynzbjnQFsI7eGeOOluMCh0GBRbCRHUlELV87AZZ5QetuMrlUdrZXnoAvlU
	 ecp5/wMLK29XxqqjNt7+p7vI71jRy/784qWtM/l+IrMhZoLnSyrNlfTAWC2gGM9w7v
	 2HWmLLFjeWGjeLn/nv6Mx3DrD7LY9KAnNHh2v415KLDJiwlonteDGXiQfP2M2QvpNj
	 uXuTL4+dma6AnM7iIbSlzmjWhMs8pvU9vzCBgMPkk/pljk/XQyV7F2AtUukiejFp9L
	 0QmzN12M+P6/PgfCH4lPNhWNum9CLrYYa2dRz+RM6o5N4wFSy51IxsuGup7t3H3k+P
	 gX4ueX8ODuwBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kameroncarr@linux.microsoft.com,
	ernis@linux.microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH net-next v2 5/5] hv_netvsc: let the core take XDP off a netvsc device that is going away
Date: Mon,  9 Nov 2026 11:48:43 -0800
Message-ID: <20261109194843.1353592-6-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194843.1353592-1-kuba@kernel.org>
References: <20261109194843.1353592-1-kuba@kernel.org>
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

netvsc_remove() lets the VF go, taking the XDP program back from it,
takes the program off the channels, then frees the channels and clears
nvdev, and only then unregisters the netdev. dev_xdp_uninstall() still
finds the program in netvsc's xdp_state[] at that point and asks
netvsc_bpf() to remove it, which fails with -ENODEV for the lack of
nvdev. That trips the WARN_ON() in dev_xdp_uninstall() on every unbind
or hot-remove of a netvsc device running native XDP, and
dev_xdp_install() returns before it drops the program from the XDP
dispatcher, which then holds on to it for good. The WARN came with
commit 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF
programs in net_device"): the core used to ask netvsc for its program
first, and netvsc reported none once nvdev was gone, which left the
program with the dispatcher all the same.

Accept the removal once there are no channels and no VF left to take the
program off. If suspend parked the program for netvsc_resume() to put
back, drop it from there, or resume would bring back a program the core
no longer knows about. This also lets the program be removed from a
netvsc device without a VF which lost its channels to a failed
reconfiguration, rather than fail. The core is about to record the
programs uppers propagate as well, which would bring the same to a
netvsc device enslaved to a bond running XDP.

Spotted by AI while reviewing the XDP propagation series. Untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF programs in net_device")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - drop the program suspend parked for resume rather than refuse the
   removal, which still tripped the WARN with the config a failed
   suspend leaves behind (Sashiko)
 - commit msg: the dispatcher kept the program before 7f0a838254bd too,
   name the function which skips the dispatcher, and mention devices
   which lost their channels to a failed reconfiguration
 - Tested-by tags from v1 not carried over, the code changed
v1: https://lore.kernel.org/20261001014131.310771-6-kuba@kernel.org
---
 drivers/net/hyperv/netvsc_bpf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 143fc0c12841..14bb520b44ed 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -206,7 +206,21 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	int ret;
 
 	if (!nvdev || nvdev->destroy) {
-		return -ENODEV;
+		struct netvsc_device_info *saved;
+
+		if (bpf->command != XDP_SETUP_PROG || bpf->prog || vf_netdev)
+			return -ENODEV;
+
+		/* The channels and the VF are gone, and so is the program,
+		 * except for the reference netvsc_suspend() keeps for
+		 * netvsc_resume().
+		 */
+		saved = ndevctx->saved_netvsc_dev_info;
+		if (saved && saved->bprog) {
+			bpf_prog_put(saved->bprog);
+			saved->bprog = NULL;
+		}
+		return 0;
 	}
 
 	switch (bpf->command) {
-- 
2.56.0

