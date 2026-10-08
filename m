Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33988442105
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493425; cv=none; b=QtHzTrdydJYiMA4WjVwoKO+MvMgagjonyG95/wV3VVXy6d/E3ORE9h4PtfeTMBJ0NQXUSai70Pu0EkdM00czCeAYis+zabFSFrdz1THFwfErnld1y1TR2IbEcU3tgkSyK16OrwjzmdjsM7noyUe2rm+MTQBevel6vF5pe+xBL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493425; c=relaxed/simple;
	bh=2MH/LzfAfYyw21+HKj408easdoK7+Tc42GivpUT/gq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5C7RnOxGXvMZ123/A/6HEdjV17yYGMCpHAauD4nSuVeXwAu2+2IGUzfISBjD0KY/3fQkbtSyEdISDTBe5QCaWTz/8ROXMmaQ8adud88GreA8yK5G57LVksNtFqi+VIsgsmLTmA7HZHsQbBvMV1ldK6yGRqghdww/nOtpLblETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ms/12vYr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ms/12vYr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917c04630c2so36701006d6.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493420; x=1792098220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
        b=Ms/12vYrXH2eKpwQL7VnAd80dJElM69FlUf+svNtv8s5GBDHkBtKTz2TsJLVvQdnnr
         9hGsfgiul5CFptZkGWd0Rsgv8QwUYv1yB/Ds3ZET85ib/pqjf1lIozdnCyBL77ibWuZu
         12SqhNIP2WUn8kYqV/xkkk+I6okqYeH+20M82lVrdh1j+2rYDLfN/WRPQ7VbRre/Gx4B
         OVI8FiF+erraivoDiCvLiqTvF6t4p7jiaGJDxp2VTAfJFDMQFyTXHx5Sl2MlQm+gwMcw
         RK3vsDLU90h4DQmJFH2YcDwMnTBPMpwTOIR6+VooDF+vDDYSJeCgBhW4rloCTol2heIl
         kj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493420; x=1792098220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz4PLreF7SMRfFt85q6B38gbUo5+Y+8z8sLQb0vICiM=;
        b=E/lCsUtJeTavbRLXe5mpSzOazJk69+K+luB/Sl11fGkIT/ul81aCPy96x0CHYh5LrI
         mgNRMMOJAuJWiE6D4cJy3ycYG5wwZX5ikG88TnSauQQg9Jowg+D+EX4ci07kFHhA8Hiv
         sPhvQGcU/FnWsDFVOo8tYb+sfJqX05nNJkRgLt0z+3H7awzE3fP/mXNAgBv0i0WIoqJV
         g/weXVBUXxqX4IIGi8gPAWpjHDeX2odP+VvaYQJwON0LC9Jx5hDClLv56OdpSygeoBYU
         YBA1WyNe+CiP9HpyRPYvFoTdCWyDuwUMMrAPCr3bL81oa7Y+Mnkd3FwREVoWfAddk4ZY
         tINw==
X-Forwarded-Encrypted: i=1; AKwUvByVeYfO63RN5zFYuBqwMBr2KIibBVYRlY+fZKV3ep1pDCoIFLVNC+XL/QGqEboq4wMuILg3oS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3FXqLfFUhHYoFSwhmBT7xAMoGn4L1XFsD2ipIq01k2gXfgpj7
	INjMmHxdt2ImQXpoQ/HUty/0+66d9uCQK1WU2+WQcr6WLhBovNpLnloHfuPjk4jRj6k=
X-Gm-Gg: AYBFou1pB3WAUDPEK0Hp4J7WBUXIqWUPywJjWSAl7XKGNbkN/OrXCozPfEdWBIKz0/T
	fE91iuHfPOBgzGsMhUsaETAEZcA3ErYCp8kYCofcjlzBwiiWjiRyvS/ovle/Wqoc4JEmtX4ZAeQ
	hng0slzQNWpLFOOfQWh9wKyDVpPa8v3USx9KAwyqonLiNA1Ld1hIqf9luZehvBza+2Z3j++B0L5
	9G2R+hkJaMvJ5SnGa+djBWxAyXr8Lhmz7EbLIPnkaKYgc/XpPHM8lB88guvValGgaEturn4DmgX
	97v8hukwGzhF3SxRURgNRCLosgvFLnjZTFuxdmouc7O0u8JNuHvFOL/nTYwsjYenHLLaCnbFSaZ
	OrWyzQACNvXhDRTX9Ug5Ts4EmBWQSLPNaT6p+Y2CWkEslWFZAciYL573y+Ztc5If1yqFwXkE53s
	tuOu+WmIywUTpbp5yS5DvHssqBspNY71FbfMYlvLRHJT8GIEqiBicjsM/0dUVaKqCyNuM2JFqQO
	T2MJs6sD6yxr9Y=
X-Received: by 2002:a05:6214:2b86:b0:919:952e:588d with SMTP id 6a1803df08f44-919978d6737mr122288916d6.56.1791493419767;
        Thu, 08 Oct 2026 14:03:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ce8a5sm77746d6.40.2026.10.08.14.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:55 +0000
Subject: [PATCH net-next v2 08/10] netxen: use pskb_may_pull() to pull
 excess TX frags into the head
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-8-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1424;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2MH/LzfAfYyw21+HKj408easdoK7+Tc42GivpUT/gq0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKxQbKwa+3oPMIR9/8wstf89TfYBkXylWZ+7HP6SNMiYKVAMjbRgDk4LveZCkr1O9fxCwKO82Xi
 ZBjyd9+CX/ww=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

netxen_nic_xmit_frame() pulls the frags that don't fit in a TX
descriptor into the head with __pskb_pull_tail().  It already checks the
result.  Switch to pskb_may_pull(), which takes the length the head
should end up with and checks it against the skb, so this driver no
longer calls __pskb_pull_tail() directly.

__pskb_pull_tail() also releases empty frags, even when there's nothing
to pull, so if the frags being pulled are all empty it still gets the
frag count under the limit.  pskb_may_pull() returns early in that case,
so follow it with skb_drop_empty_frags().

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 67d9bf69f8f2..f5f89ed87d95 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -2045,7 +2045,8 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 			delta += skb_frag_size(frag);
 		}
 
-		if (!__pskb_pull_tail(skb, delta))
+		if (!pskb_may_pull(skb, skb_headlen(skb) + delta) ||
+		    skb_drop_empty_frags(skb, GFP_ATOMIC))
 			goto drop_packet;
 
 		frag_count = 1 + skb_shinfo(skb)->nr_frags;

-- 
2.55.0

