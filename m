Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BD38DC44
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255150; cv=none; b=t03mJu6mClPBz6hyvocIYm4ZEYkRperuggwZj0Eny2bti+gJwiK7IuGqxxtBiwHPJrKR+P1DoGumdKODRh4FqbesaMMRbjFmuwOH8FbC94+++AMa9xnTAYZbvYRu2zovl+yVAp5crQmqxw3/5Ay8RzifX9uZDKpGM39QmpGYPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255150; c=relaxed/simple;
	bh=15JM/mSud0IjBzpDoAVYXaH+6YiS5VMg16ugA8Itw4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHy7ZUY6IgDnnnrEH6b6sR2cQ1c9bPQ7SQotA0aBJduPkPy9CuBSXa5p24xD/eNkAjVYK1TDvVV0YHk2JkgppMgJIp+/kqAijKzbDw99XWcOlzszak0bAHeehBU9WS2j0dakjGPFFB6T1jLc3spgAzmhS4V+4FsHx4IUagQrKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itRlIWyE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itRlIWyE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e940d5d2beso2845935ad.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255148; x=1792859948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVW/Mvg/9zO8L5UsFw4/IZhgeVizToPaRZeVZDWENbo=;
        b=itRlIWyEhF50p+h2DIAt2sumoLdkL27yboCcrjqoGvzACVKzfO+yFQScfFRPt29qEI
         0hRxY4TICWx9eKO76erj35yBLAJ3Era+OCt3tzdPQFB3bMupVpnjHPHXv1dZ5DtaPE2c
         mWIdLAiguZ1QBPi22n2uGNnpFdaft/ZPKXfpX809V+SnJBkOe9Fpu7+4aTrC2RwKH9LQ
         9RxD+Zbg4j9cW60eWiKsyTRCaHwyvsVMu7M6judDZhsx/0oJjRR6sKimaVSS/VWeubrJ
         zoev6r/I+AElZdaMV7svvLRx4IkMd+IrlClsp2Xf0p+YhTdW3F2SUAC46P0/8BGL2zSQ
         up8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255148; x=1792859948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVW/Mvg/9zO8L5UsFw4/IZhgeVizToPaRZeVZDWENbo=;
        b=jBpY6JeQ8YzQttv+ZmDnX0EpNnj+N3UCi1eDJ0g0CNR7yVmfyac3Sq3lhJE+xCu/ZJ
         7p/q2k3vDPb3Oyz9EpuH2J1SfsLgROy7poGXOmjRd+a0Wki3QjtTLExVdg0kGK0zrL/0
         k2ANeWXEiE94S8+D5QquMbZ8jYFdFeErVy9LFYBcrgkCwr35eSu8V8pDTOAGqMZlxcQu
         VMP5fPbJ9CT6C53hqRIOYKEHl29HvTux7kazn/Uy7tF5rCdwHiLVSTNEPQUWaWTsy0we
         5AgmeqVuUIOnruBWXcG8SJQSQ7P+vgS1MRO5WtOKnT3j7HSadrMYnFbt9USGzjnKM2uk
         qsUw==
X-Forwarded-Encrypted: i=1; AKwUvBzYmNQKMU5qopE3YPYgAE4LG1OPRLySuJoLcmvBXF8uv5m+u4qEiCXaynq3WJvdKhZBKEdnZEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ527adfUn90HovGy+itYGERfBMvFPkvoZG4gowCB1ckYm8KOoY
	o6ayJIoeN2yE3VLD5WL15bqFxhF4gLsO3bnK9M/FMgm/Tfva6Wg3oWAG
X-Gm-Gg: AYBFou31SXdpFqm/eke3myKENN/ggLqvsA4QJdBiYCZBCFdEP0g8TG1DVFmX2bPksDm
	+TX/pR3QEoqH8lEv4jExiRsVdWMzkIP/IctzK9RqTEHd7keM8TkgfeUHyfWMOPxkWVJMUjpxCc6
	S18Qxg6SfQmr9kw2SgEE8u+cNBYY53oVtoAd15/1DyUMDk6jkjKntqPyqMrR3BRk8zxHS32WYq6
	ur9RmKYEYms7aFhSfHMLwpRTQh696sboCME/bhNVO9cLALRlq2x5Ngz8HHDEgaA7ry6MthGxT4M
	XwH5snZCZqPi1C6rv8yZVkHmKn79XffBwxiLC+L3jRS7jzdT8vzhYwbLrBqm5OcFudEqr+y+HDD
	rjNNouyPPOu4Sv4en6Kg/F8WZ00/cz4rwegt83cB2IEoxgdoXE3Ol58DtzNXQZYCxLtWOqTBpmU
	NRJNeE6FmCp/G1i0vg+S1SsKTwNGk9+woRscmPWqGQ/wbAZKR9lYM3PvyK3e5qws5H8dCmQVQKT
	tSeB2d+9B/ifc3j/s+vDD5nnLLRU99cCK9YkcwQuSIyBJ9J1/c4g93GYR4N6+az4mJVl4Fa68Ud
	XHh7si7vGZfOC6mTC2VsyXDKbvLLknKEZCavJKgvgCl6
X-Received: by 2002:a17:90b:4b92:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3acef52acdbmr2740344a91.49.1792255148056;
        Sat, 17 Oct 2026 09:39:08 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4991b8asm8701822a91.16.2026.10.17.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 13/43] bpf: Update the SRH state if End.B6 fails late
Date: Sat, 17 Oct 2026 16:37:15 +0000
Message-ID: <20261017163745.3341787-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

For SEG6_LOCAL_ACTION_END_B6 and END_B6_ENCAP bpf_lwt_seg6_action() looks
for the SRH again only if bpf_push_seg6_encap() has succeeded. That
function pushes the new header, for which the head of the skb is
reallocated if it has not got the room, and then looks up the route to the
first segment. If there is none, it returns an error, and the pointer to
the SRH in seg6_bpf_srh_states still points into the old head, which has
been freed.

The program goes on behind the error. bpf_lwt_seg6_store_bytes() and
bpf_lwt_seg6_adjust_srh() read the SRH through that pointer.

Look for the SRH whatever bpf_push_seg6_encap() says.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6fbe0cea2140..15354134091a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7087,8 +7087,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
@@ -7096,8 +7096,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		/* The header can be in place although err says otherwise */
+		bpf_update_srh_state(skb);
 
 		return err;
 	default:
-- 
2.55.0

