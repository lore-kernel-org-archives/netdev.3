Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603504;
	b=vJ1uMvBjwFGgx/Yi4v0q95qPlRK99OQKG1NQ1j8MMtcoFeUMVtTErRA/x5ewspKNEiJx
	 uB4XQjimgyAXX63eJ3kZPy9DBvMo9l9lTIFUt9beFZb+WvomuyYk0/Pdk8PxuTSaEgrmX
	 ZWJ64Oi4Wcxj4MKjBWX/TMz5EoMR7WdZLFG1nQN1QFWGFyzzq/NE06zG6guF1zAWIxc4O
	 JZBYXge5gFE76C6RDIls1h7siilxl7zQokEL6u/DOXfkckZGDphviZjO5pWTK/NB4N9AI
	 hvCgm6SiIyu6Qs2td9i4if+Vqr+Gcig3VfXOdbIeTTrDxob9Hm5T8Fv8dXn9fNY2c2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mb/1g8nYCeIwcAw01UT60I+xXfiBOSX5Y/kTWaVFrFY=;
	b=jrxqSiuvvpvdPHVxmFnGQEmtsMlFFdrhV8FJ/iSdyTMVC4yxveOPbT0ZgwjYclazqxZG
	 TqhnClNHVxFfiTVm3b5CRVTzMB2lWDrB92u3W+0zmWaB8feSlKX4+1opB2tncZdL/ztGv
	 1GWkKzzdYfm0qARS8nHTAuC7Q4/ON15t/gmmXQFdMtLno8rPlu7OZ0pzOEAYqFwtaN/gS
	 BYGgJWUU7gAAshh2LZxw3JcNZwMU+bP3y9JAnvuNgTMvBB7YAcocxTdQBqoq9VD+RQVHk
	 CxKOsVZLceevn77XvPT/ejV7S2U9FGe2my+2OkkWnUmIVC8BiKYXYGwMqxCNdnik0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eT3wYLlN;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3646606A330
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3646606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eT3wYLlN
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b436dffso682521b3a.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793603503; x=1794208303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mb/1g8nYCeIwcAw01UT60I+xXfiBOSX5Y/kTWaVFrFY=;
        b=eT3wYLlNjgKoDJgrmPLVf+z53ie/PBrzWlNf3RchnvysF5anw64TyRRgmRH18FfzOV
         7jivWYbcp0PkW1F6FaEIJPI7U0r4renRH8Nxala5yjWMlzsCJ/beUiSQ4QXzcxewJMyR
         krwWkhhNWxZeS1AOqf5A/4miQ+h5iAQf+SG85kk9+rBSzFjPlscdJcTOiq70rFpA05oM
         qn9NXnsQjtS0g1WwJ4AN/4qTj/Uc+fLzGNGvb7TuJuhOCBkCxWyq8JKVugi+4O36rQ09
         LRax8nRmHSrQgM0RoWu6HSAPUsKFRxEpqCjmyOUmrnukOD9+3RGzyowIZqopDlMr3pWF
         erew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793603503; x=1794208303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mb/1g8nYCeIwcAw01UT60I+xXfiBOSX5Y/kTWaVFrFY=;
        b=ZPQfZaFqPNPwi5bE+YwaqZPitOvaZeAC+N43DTwHtDfDWXD5An4s3Tp9Rvd0QuLhuQ
         SBBQ7++Nrbh/hNBvuKYGFpnb2caCrjXr058LdJtQvise/zFOH8EOBSXiuhMfn+/NEHfo
         pmoy2L7bvK35E2ELOk5Ok+qMBvH2ISWUcPPQzegz7DQIDpNHfPDlUoZgQmtIkf6ZLh5t
         RwePGcuNS1pz3XgZ5PFsoBFUiCRFX2zxKqF2iCNXfsZqMO8d1BMqXZq6K+SA+ZUejhi4
         pkZdQZ9+HnvYvXH0nUr3CCV13R0oEBiIOiocMpB6iahl317PwqbqeMuYE2nmS/kxnX7x
         lICA==
X-Gm-Message-State: APuU4Z/Ui+cYdXuEeOct6WkMTcikwfSyTaKsz+MeRHq0WCBtnYlkzDED
	imho9pr7LW8WbEBOQc8eRxCGMqHnzC2JZQ1sstMI+mu/TPadjyOLKk08NWlsdhvq
X-Gm-Gg: AYBFou3SP0XM/8IUiSNRWL64pqqcpuF/PZCY9uh557l8gxFD8P5O4hO3SeWqUbPEzUF
	Xyamnz9LzFdiJB+RnOzTSM3w1DWfQszgx6tCcC02MNW7SLtOHEdflSaQKz5wMa44rFjkiEkKpIs
	gwUnRRvqiE1uYfxUtG1fbVHpV2V2Ffo1+sqYY7LPqUPEBgMPygUKAD4Wkmm3TyddRY3s/K1U4Ly
	wcyv4ansCSO9ko25NSP/pZu3QQhH193uv8NdRxLb+45l+wHqhw2nbrzIfymUt1phP86A3aIzNro
	qEDhUTetBXbLDuw5C71Ti83PZThW8MTehofs40jZhb74SVnIfqqMVYijeQl/O/6ouLgqge+c0Hh
	YqPYQGFuj7QJcxmYKD1S0wUwbq0jHA1X5PfyooL2lJrIPaxJPTWOF8HB0G3sbH9/0Xxoyx3jQ1H
	puYai0mn7pFqw10NTbmpVuYQrJLGBd1/+Oj7OqqTPGwjuh8A7tPsYbYzKPOFvhEcUkY38d1vPoX
	8nJh4orvq2/5Vv2s/znKMiCuG8VCs9f8vhFtydDVoUT3RpyHD6s6PBATuJMtHF6KKB/FLs289yE
	4oHz4FuW1CbGbAADpRLFkVG7H4C0OAD/1XncxzwtnT64UNSNeP7U3w==
X-Received: by 2002:a05:6a00:4f94:b0:89d:ec58:ce47 with SMTP id d2e1a72fcca58-8a9c05ab245mr7894823b3a.55.1793603503283;
        Sun, 01 Nov 2026 23:11:43 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8abab0c6c6esm1140566b3a.48.2026.11.01.23.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:11:42 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/4] net: dsa: motorcomm: Fix extack message on unsupported TC actions
Date: Mon,  2 Nov 2026 15:11:13 +0800
Message-ID: <20261102071119.3435180-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102071119.3435180-1-mmyangfl@gmail.com>
References: <20261102071119.3435180-1-mmyangfl@gmail.com>
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

No extack reasons were given to unsupported TC actions. Fix it.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 9dbd61e48fee..8835907366bf 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1122,6 +1122,7 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 			break;
 		}
 		default:
+			reason = "Unsupported by HW";
 fallback:
 			if (cls->common.skip_sw) {
 				NL_SET_ERR_MSG_FMT_MOD(extack,
-- 
2.53.0

