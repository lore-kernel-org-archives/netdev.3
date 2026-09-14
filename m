Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7B475346
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394968; cv=none; b=lzRf1UQxalH89nsbTzMrQzq5NaEcL3AYtXSFz2QZjw688/EZPUxEBsRcRyFNf6kPvgyox2rZHki4JGyLUh8luNjK8CEx5+f7Qh7Io2qbZAxaKWxw5QOlme2oP72UtgUkyvuDBmlRgYVLGrN1gFhvWGrO2+hkUlmpRrpMSKOVn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394968; c=relaxed/simple;
	bh=Sx9v7HQiEuMQMZvcpJR8rOdiRwK04scS8R7dUc9Mdd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onBaIuO1s/ow0RD+TumA/NNdk6l0NMkITVh3izGZDvpgSZ7zUM/NP0cGA06q3ZMXyfyDCuQUSTWo6It4QB9DMXBv3Na5UxcEokdD7otpN/6rikchIcbLhB2Qz7LaVLJnNlO+izwCzWRVEfXJD7AImfu2nvbl0oiEe+VK0zRcGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUG4NIdx; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUG4NIdx"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a1f75375d8so633861fa.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789394960; x=1789999760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pp0hFi9J6OyCUNkr2fkBiI3LoUNXdAPY0thZeRETuic=;
        b=OUG4NIdxrWOv4nsxlrEkH/NERMzSyv8+xM3bqd5C7mplN6LnJtJWoztDjVeuFCs3O1
         m0rpUneCPhLnuUNItZBXY/+de2TCoH9MmJpLsj1YhnMt5Ew6Cd3/txbY//ewnAU5zwzy
         3MLS4Ot3YdnN0GuTfEJi8JIhPdULkN/PfSgYLg6znIdWMf+2Z6P/aLR2OuB5MmSsdSdj
         7HP9sKb2xD4MIDABVRVuuFb3jFSO8CKYUizQjcnJKT92L/pUGLcTHb69POFz/SFb06dA
         /Vgf07pSSlGHWRbmRgx2MSD1DVXsQ49ykfl/G2Nw1wof9gf/nA2jL/l1a2R5SlwRsWup
         m81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394960; x=1789999760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pp0hFi9J6OyCUNkr2fkBiI3LoUNXdAPY0thZeRETuic=;
        b=I5vmJjbgm32hGBR4gZKZD5vzuFCy2ZOrbsiA9HBJMXK3jNGPrMBEaO9QKRhwk349K9
         +e/fjau626ZIkmrRubGfQyOmJRGF8aYx9JTIBFvSpJEe4tAaaCmkzB5v2/VfM8rwrOsZ
         KiEnepqtWAG4bHt8l0R4h2jildzqJixZagaiSVRhxImkGiI7ebH3oZ3dFLHqc8QUItJt
         VEI9mtlET6atXEVVp4PbS630sbkPbnDY0SN7LYLVK2oYAnbDOgO9zFFBPhD2Vp0IdsWQ
         RIrrahe/gsUF+4z33B9nT6LE/dOI1wUm6Q/K+PGC34aNSX5wL2pQzjINpiAXjjlMsQKI
         a28A==
X-Forwarded-Encrypted: i=1; AKwUvBz9+5FFDm0ufsh1FMbw7ZZL/3568jQcKXrD3SiwOP4UKsxzDjZ9GGVjHGw7jN2sMvklJD0tWMg=@vger.kernel.org
X-Gm-Message-State: AFuF++mfx5PvFjCSczR7FJvUFOhB9hHciOfNmqVrb51+R4VbIc0m3gRh
	d7WdOT48lVvxn7DGHJGoS7rVzCCL1H/sv+J5eWpAU0BxaVROOYvRESy7
X-Gm-Gg: AYBFou1hB3PijoOlVjOGJvUOCiPUb7D0WSHF64Uq+3M7lRzF6cFhx592IIsobORTPBX
	0sB+2JwIyN7TkDHqQR171MU0FPTI5FRbGazwVFbJP8xoWJsdMaZEdv+7minG5llCTDahFckW7Jy
	qwUorV/4MMl6AtH6mEQfqgQ1r/Y8oH9Tum3YehIqSiSC6mqC2HrTSgW4gYqCjWdg7e8RdKLtasp
	9GXkfEjP0qVk7X+1+WNtE4x3aoqeArU42ObcKfpsLsksYgEBzwTgdTltDuDLbe4tkcmrQydSfIU
	v5fvUTcekrSiqGhe6avONl/tlUGoZGuXSf9lijBKvOdEl2Ig7pyqDRIRRq4L5G9AcTdcnar30a8
	djUH4x9DkaeHfkjj2DjRDNNbwF7hnR4OIQ3poosJd0cUwMiffkSQ5/cLp1J1hjM49KzyRbFPeus
	ZPn4Q5HBrqtNUwPoRbsakA+zpeUEoP4wmc9ZOJciMCEWwKSLF4rvwWuc8rPcgP+OoEdRaxUoojY
	8PDUtSdz6dajg==
X-Received: by 2002:a05:651c:a189:b0:3a4:9eb9:b9a6 with SMTP id 38308e7fff4ca-3a5c86e8186mr4063111fa.0.1789394959809;
        Mon, 14 Sep 2026 07:09:19 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3304565sm25772221fa.10.2026.09.14.07.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:09:19 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lvc-project@linuxtesting.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Tom Herbert <therbert@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] fou: Fix use-after-free in fou_create()
Date: Mon, 14 Sep 2026 17:09:07 +0300
Message-ID: <20260914140907.196765-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

commit b14361aca6350ff7907b0e9903c7b94dc7d5d4a0 upstream.

fou_create() publishes struct fou through sk_user_data before adding the
new FOU port to the per-netns list.  If fou_add_to_port_list() fails,
the error path frees fou while it is still reachable through
sk_user_data.  A concurrent receive can then dereference the freed
object in fou_from_sock().

This ordering issue was previously noted in the linked discussion.

The failure is reachable when local port 0 is requested.  Each socket
binds to a different ephemeral port, but fou_cfg_cmp() compares the
requested port 0 and reports -EALREADY once an entry already exists.

Release the tunnel socket before freeing fou so sk_user_data is cleared
first, and defer reclamation with kfree_rcu() to protect concurrent RCU
readers.  This matches the lifetime handling in fou_release().

Fixes: 23461551c006 ("fou: Support for foo-over-udp RX path")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://lore.kernel.org/netdev/20260502031401.3557229-12-kuniyu@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20260722083858.182506-1-xuanqiang.luo@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 net/ipv4/fou_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0e173998f1d7..790791d08a1c 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -636,9 +636,9 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	return 0;
 
 error:
-	kfree(fou);
 	if (sock)
 		udp_tunnel_sock_release(sock);
+	kfree_rcu(fou, rcu);
 
 	return err;
 }
-- 
2.53.0

