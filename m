Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB93D0932;
	Tue, 15 Sep 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461426; cv=none; b=U07OrQd+pWDqAzGfw2px4OA8iN8RPUc7XWzbjIsyR6ezsH3A2ONwQEb80LYcrsG8obOGqShVAGjUaQd7EPjbt1Eott1hXk9dSlyWc6c6omQLuOt20IYzkS7DdpuGUqgLnEx9YU9XlWtJKJVB22PtOGXCyqK0pKsI8TqSbRWiTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461426; c=relaxed/simple;
	bh=WZW58imxrH+dL0ShUUgw2cmDpsNuhzONZ2dOXdQmIno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N00okd6oHKe7UxDldrbJzozIYl2aVD3KeNeQgW4Q3LoM9En+sJWY8o9CGjBoWRlrDFqCWydBPoEj/Mq68rf50/TuGQwoi90sR4fR3KefdL6jtXRKmGv/5p8H3q9YYEFmLnUj64Cu1D3q4hfOQjmn1pA4l2DytoAmxMgeD5autdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=JDmxVtrg; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JDmxVtrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S4
	qdnUSRXu9jp2j6e/xh0pE4PAJYYoTSoLGlLBucJUA=; b=JDmxVtrg6IVuJAAT74
	zftsrXhgTNAPtfYyvMWB6VkSeSoK2VbKUyokz5SPs6nCQlwEyI6ENo8iBpXFi5uW
	iJXBI2telQXprW7FFX5x/Xy6qmmzMFsmdKHxVeJJNS1+agnvlALjec9LmLBoWCLB
	2UxCjn7ggfJm08FiuuHSZ+xj8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCXdbmdA6lqQxoPHw--.53987S2;
	Tue, 15 Sep 2026 16:36:46 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in i40e_xsk_pool_enable()
Date: Tue, 15 Sep 2026 16:36:43 +0800
Message-Id: <20260915083643.506113-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:PykvCgCXdbmdA6lqQxoPHw--.53987S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryfKw4kCry5GFy7ZF47Jwb_yoW8Kry5pr
	Wj9a4DCF48XrW7Ww4kJF48u3WrJw4aqa4UK3W3Can3urn0qF93JF4xtFWYg3ykZr4kJwsx
	GF1DAwsxCFn8Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFeHgUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlB-sw2qpA5+xUwAA3Z

Hi Haoxiang,=0D
=0D
The kernel test robot reported the following build error on your v2:=0D
=0D
  drivers/net/ethernet/intel/i40e/i40e_xsk.c:130:9: error: implicit declara=
tion of function 'i40e_xsk_pool_disable'; did you mean 'i40e_xsk_pool_enabl=
e'?=0D
  drivers/net/ethernet/intel/i40e/i40e_xsk.c:141:12: error: conflicting typ=
es for 'i40e_xsk_pool_disable'=0D
=0D
The root cause is that i40e_xsk_pool_disable() is defined after i40e_xsk_po=
ol_enable() in i40e_xsk.c [citation:4]. When the error path in i40e_xsk_poo=
l_enable() calls i40e_xsk_pool_disable(), the compiler has not yet seen its=
 prototype.=0D
=0D
One way to fix this without reordering functions is to unwind the two opera=
tions that i40e_xsk_pool_enable() itself performed in the error path:=0D
=0D
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ether=
net/intel/i40e/i40e_xsk.c=0D
index 9f47388eaba5..97d016be493d 100644=0D
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c=0D
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c=0D
@@ -108,23 +108,31 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,=
=0D
        if (if_running) {=0D
                err =3D i40e_queue_pair_disable(vsi, qid);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_pool_unmap;=0D
=0D
                err =3D i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_pool_unmap;=0D
=0D
                err =3D i40e_queue_pair_enable(vsi, qid);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_realloc;=0D
=0D
                /* Kick start the NAPI context so that receiving will start=
 */=0D
                err =3D i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);=0D
                if (err)=0D
-                       return err;=0D
+                       goto err_realloc;=0D
        }=0D
=0D
        return 0;=0D
+=0D
+err_realloc:=0D
+       i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], false);=0D
+err_pool_unmap:=0D
+       clear_bit(qid, vsi->af_xdp_zc_qps);=0D
+       xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR);=0D
+=0D
+       return err;=0D
 }=0D
=0D
This mirrors the internal logic of i40e_xsk_pool_disable() [citation:12] =
=E2=80=94 clear the zero-copy bit and DMA-unmap the pool =E2=80=94 without =
calling a function defined later in the file. It also avoids the limbo-stat=
e concern you mentioned in your v2 changelog, since it does not go through =
the pool-association check in i40e_xsk_pool_disable().=0D
=0D
Alternatively, a forward declaration of i40e_xsk_pool_disable() at the top =
of i40e_xsk.c would also resolve the build error.=0D
=0D
Best regards,=0D
Linkui Xiao=0D
=0D

