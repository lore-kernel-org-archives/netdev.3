Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838865;
	b=q1ZVrmyUGKxXhzjrjx+Lct6wlQLBmPNVPUfteyDfGx6V8YpCSDoRV32SiE/26x/kqx7b
	 0A3AV5+SMI6Yeb77PYIevDo5IXEVSE2YJFWaZj/d3HnYWBfd97HkoVegH/InRbC5B5GMw
	 vAWDeOKetqlpbxzZpDtp5tM+wkmVK9EipVbPR+9tayKn4gQUjQPumuTU0rArMIYyP34wP
	 /TL3mIQ3QIg/bWdXS6bs9JqHj+rSHtKDFrZG6vCCt3slEB+3m5OBdt7qGaon3OwPQPjkK
	 rLywhMn5jg1B6b80v62eXfcgBcXddc+1/gd3vXTDqLrszxw0n/Jl5GmJcuwA3XjU6rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/wakDxlRkI5CUD/1gSahs8ohVfwl2XLfxDWVsBSy3II=;
	b=fgL5Y2EFmsERZwzrGz9U1iAb31+TzE4RHa383NkZ4iiM9VlkFCHCgJQCGoTpKpLiYPGv
	 RrwF5t38Y7GoQR/+Nc8NobVtWkBQW72l6l18S9b8P2eg752e+GQ9qP98/pjZs/NnWD9Rm
	 rvftvyqNKWGp9/L1hR0qc1HhOa2wnexBMPhcF1j3oCEiEj7Z02RjvY9X1nTXnfVLsztDp
	 N81xL7yxYxaPxc9lGQ/Qy/I9f2dkS8r3ucnFHX1Cp2JfbKlpNvdCl42Yihes9E+JS7f4F
	 NBYSMxcf3g4u4OuKmucXkxPn7/iAg0PXUJs05QbH4MvQ9M/zHNkhx3TF5czxp/hNN+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9ZhdQb7;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92F606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 00:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F92F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9ZhdQb7
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53644b28706so18282451cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793838864; x=1794443664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wakDxlRkI5CUD/1gSahs8ohVfwl2XLfxDWVsBSy3II=;
        b=m9ZhdQb7b1fOKNjTuwpUYSC7rj+8bAYP/YpXKlURZgeZZRXeuHHlSQGJSRtW3j7imG
         QpX6kYHpjMZTW0uvhKVbbhcZF6eUFF9KULMFMHH1lmzs0K67RJZ/IVgdKTroAomQgl8V
         F2X8io7mRqUjlfo2KriPKqd+cESwTD1+VlPKAkY7oq0RaxJ3XisDxTlxl3nWNMdzonE2
         8DK19/1ES3zhSH9E1NnDc+KX8k1chf21cWDEOq4OKDFmritgzAPVZ1OXVTdYvBaVnwzk
         iqMjDQx1K42r3w0sFykFNT+rF0NxHP+06dkDTBHGHFL7kxB/o+N6LflvHUUaDveG9qpf
         rsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793838864; x=1794443664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wakDxlRkI5CUD/1gSahs8ohVfwl2XLfxDWVsBSy3II=;
        b=GOa/tSxWBTzAztaPsNfOdw/VxRREjXXsfdvYtSM/9nidta3RN9qGIqf0jhmHri3Aah
         HaWQWOPmWQaEKC4yVUMfhH1Y6IIfP7we9cbIIUodOovLxTFZ7we2YOuEqL6XOZ+l1XVo
         cGC084P2CMmznIelTE2a0tPjKzQAMMrzStv2lq+ePvCjFsHC5lWWOX5r691mxQ3yQ+GA
         gy0EkLMrY8jS1Tu7o60xZ9m/UeLSHqAM9t7OJTpRnNlSl6ttP6LkyFI2jNZmcW/gkogc
         0jbBQiLIJaMtniP4mSASYPNoVAjBsG7+bYGBfyy5CSYaezF6/hmMbQq2Oo3nYDKy0QOZ
         3zKw==
X-Forwarded-Encrypted: i=1; AKwUvBxwnmvUI31EzLrEcbf1vtI2dUNMPaY4rYUylRdMHfLQMk4j7wlvbLWcCik21/YO31gwk0/GGqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z96SRNk5FGQX0qT2UBiztdL52u1/5HVdUbzcMt8IOchG3FaiB8f
	QZiFLxZqHnrkm3niXj421CWwiKofEvAp6EbaBnFJEqF9ZK2FiAl0S2ep
X-Gm-Gg: AYBFou3QQzvZJDb844C5qGgdWNcGjBv8cwNWsINtbcBaYo3OeeK2yN49hS/YKSa3UbO
	HrhQwxaieqJJuxt3Nq/oeRGkSnWZKqghbzj8RTcA0/uQGrH10oqnj/2D6594iW709ZgsZlqh6fG
	FZlsQi33JO+xd99eAk5Rezcvh7Ay5nYDTJnJO6+OvqS5zN4EnbMkbwHcz6ZA43LHlbSBaFPdQE8
	+HZTMqboThazYt+SJF3AIX87fRRABfnE68Q/JcEPBfWPVHkmfpZ+O9IbFvULhXHmMNjytVbDNFB
	TNd3ce1CgfhZQiPTORHuYwGb5zhXePsc4iaYQHa1/HiIU3xG9gBnwo5wADEkiXCSEhaMnb6bI9P
	n656quqgdP2StjhHIV2G+DTaXPHxZOCktRCQO2/ddnFai4gYkSBeifKsZ/S1rV64PfD5T9zeFR6
	ZwedSwgkVRDhtTaICx3AYqf8EMNsvREQjuJ/NyNEJvgPnaFZadMrECBC/qpaIQKZByMAOduBsKF
	w9vwKl0/mjAMY6UANN4tofggFUt8nEya0DOI+PtrcZF4UQEjBLmN0qkI/22xfPKATO0baAKqLTu
	pWRnfeffn5DuW4WQ2Q==
X-Received: by 2002:a05:622a:2510:b0:536:72b4:b835 with SMTP id d75a77b69052e-542b7141e17mr309174441cf.46.1793838864178;
        Wed, 04 Nov 2026 16:34:24 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b0d0758e7sm37705821cf.3.2026.11.04.16.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:34:23 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Joas Antonio dos Santos <joasantonio108@gmail.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH net] net/mlx5: macsec: Don't remove fs_id when adding a rule fails
Date: Wed,  4 Nov 2026 19:34:19 -0500
Message-ID: <20261105003419.4016283-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
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

macsec_fs_tx_add_rule() and macsec_fs_rx_add_rule() clean up a failed
rule with macsec_fs_{tx,rx}_del_rule(), which also calls
macsec_fs_id_del(). The fs_id is never in the xarray at that point:
macsec_fs_id_add() is the last step of adding a rule and removes its
own entry when it fails.

macsec_fs_id_del() then dereferences NULL, through macsec_device for
the first SA of a MACsec netdev and through fs_id_found otherwise. On
RX, the SAs of one SC share an fs_id, so a failure while adding another
SA drops the reference that an existing SA holds.

Split the rule teardown from the fs_id removal and do only the teardown
on the error paths.

Fixes: d4ece08f4b1d ("net/mlx5: Maintain fs_id xarray per MACsec device inside macsec steering")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only (x86_64, W=1, CONFIG_MLX5_MACSEC=y). I do not have
MACsec-capable ConnectX hardware and QEMU does not emulate it, so the
failure was not reproduced.

 .../mellanox/mlx5/core/lib/macsec_fs.c        | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 7d785c937d43..4892175ca577 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -764,13 +764,9 @@ static int macsec_fs_id_add(struct list_head *macsec_devices_list, u32 fs_id,
 	return err;
 }
 
-static void macsec_fs_tx_del_rule(struct mlx5_macsec_fs *macsec_fs,
-				  struct mlx5_macsec_tx_rule *tx_rule,
-				  void *macdev)
+static void macsec_fs_tx_free_rule(struct mlx5_macsec_fs *macsec_fs,
+				   struct mlx5_macsec_tx_rule *tx_rule)
 {
-	macsec_fs_id_del(&macsec_fs->macsec_devices_list, tx_rule->fs_id, macdev,
-			 &macsec_fs->sci_hash, true);
-
 	if (tx_rule->rule) {
 		mlx5_del_flow_rules(tx_rule->rule);
 		tx_rule->rule = NULL;
@@ -791,6 +787,15 @@ static void macsec_fs_tx_del_rule(struct mlx5_macsec_fs *macsec_fs,
 	macsec_fs_tx_ft_put(macsec_fs);
 }
 
+static void macsec_fs_tx_del_rule(struct mlx5_macsec_fs *macsec_fs,
+				  struct mlx5_macsec_tx_rule *tx_rule,
+				  void *macdev)
+{
+	macsec_fs_id_del(&macsec_fs->macsec_devices_list, tx_rule->fs_id, macdev,
+			 &macsec_fs->sci_hash, true);
+	macsec_fs_tx_free_rule(macsec_fs, tx_rule);
+}
+
 #define MLX5_REFORMAT_PARAM_ADD_MACSEC_OFFSET_4_BYTES 1
 
 static union mlx5_macsec_rule *
@@ -883,7 +888,7 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	goto out_spec;
 
 err:
-	macsec_fs_tx_del_rule(macsec_fs, tx_rule, macsec_ctx->secy->netdev);
+	macsec_fs_tx_free_rule(macsec_fs, tx_rule);
 	macsec_rule = NULL;
 out_spec:
 	kvfree(spec);
@@ -1648,15 +1653,11 @@ static void macsec_fs_rx_ft_put(struct mlx5_macsec_fs *macsec_fs)
 	macsec_fs_rx_destroy(macsec_fs);
 }
 
-static void macsec_fs_rx_del_rule(struct mlx5_macsec_fs *macsec_fs,
-				  struct mlx5_macsec_rx_rule *rx_rule,
-				  void *macdev, u32 fs_id)
+static void macsec_fs_rx_free_rule(struct mlx5_macsec_fs *macsec_fs,
+				   struct mlx5_macsec_rx_rule *rx_rule)
 {
 	int i;
 
-	macsec_fs_id_del(&macsec_fs->macsec_devices_list, fs_id, macdev,
-			 &macsec_fs->fs_id_hash, false);
-
 	for (i = 0; i < RX_NUM_OF_RULES_PER_SA; ++i) {
 		if (rx_rule->rule[i]) {
 			mlx5_del_flow_rules(rx_rule->rule[i]);
@@ -1674,6 +1675,15 @@ static void macsec_fs_rx_del_rule(struct mlx5_macsec_fs *macsec_fs,
 	macsec_fs_rx_ft_put(macsec_fs);
 }
 
+static void macsec_fs_rx_del_rule(struct mlx5_macsec_fs *macsec_fs,
+				  struct mlx5_macsec_rx_rule *rx_rule,
+				  void *macdev, u32 fs_id)
+{
+	macsec_fs_id_del(&macsec_fs->macsec_devices_list, fs_id, macdev,
+			 &macsec_fs->fs_id_hash, false);
+	macsec_fs_rx_free_rule(macsec_fs, rx_rule);
+}
+
 static void macsec_fs_rx_setup_fte(struct mlx5_flow_spec *spec,
 				   struct mlx5_flow_act *flow_act,
 				   struct mlx5_macsec_rule_attrs *attrs,
@@ -1833,7 +1843,7 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	return macsec_rule;
 
 err:
-	macsec_fs_rx_del_rule(macsec_fs, rx_rule, macsec_ctx->secy->netdev, fs_id);
+	macsec_fs_rx_free_rule(macsec_fs, rx_rule);
 	macsec_rule = NULL;
 out_spec:
 	kvfree(spec);

base-commit: 6baae996ecf6a3f57b08ea6f6786e29af9260f51
-- 
2.43.0

