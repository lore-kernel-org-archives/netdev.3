Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3F3914F5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746985; cv=none; b=j8krEPukt6D1xG5M/FEm2zyZd3gtlraRf5QBMlnOypboBO7q5i4URoV79e4JWqwSOHf+XgvA6p0Bf4iuJI6at1lCOERWlx/fkzVaBRmJuU3hJwXQ6vw1vZ0pyzERDB/rkWwypt75M/DOKgxfZ2j2+atbOdCu2m+MzvRF+wuMHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746985; c=relaxed/simple;
	bh=naYiAPIkKFS4lMIHjw1ww11hOjagpIMam5a2heARA7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k52Ia4o+QTveca6/7YWHHYr3IyEHxIiH+SFBKTqBF9HmkYUPyNnFPAK2io5BhjlpK6RQKOJISga9Sp0M65PYphIIxN098z6jGhNZKk5yd4np22k12dtJxRMoBw5jS+ywqwZJevw2EpFzA0aG8vy53ZTIFWTwLgTUvOWAXJYhKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT+Wn9u9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT+Wn9u9"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so2402641a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746983; x=1787351783; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNmr1ayQAvvric/X7TwlZcEWHDeDXUjRegOVWX5UQX0=;
        b=kT+Wn9u97JmLpZVmMcWJFQl8etvGXoIFyzFIRry/pcHztrWtQNcDoknJ/dNzH8YEmA
         8yXYpiKpVQBCDvf2KGsdYBRCg3tdQw102erdP20dJ6iYj/j7YK9X33L9LLX/tX8gflSt
         RkoownteWmRjZ4eMPI/Cig1Ra0OEX+tI+gWiIIyyOICcx4XvAaZ0UshcX14XFNIM6W1R
         eOv56zv0yQIkn93+9GPjQthELzbwmZcXNVY7LI+IBeBpCPXKzXY2vaYteq5Yx268Poxv
         CM4zzKMnxsPVkSkeA+xu9Jufm9rqvo03l+DvmlZ4xqNVq3h6ZdCkT6K4w+hM6NTKKUY+
         m2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746983; x=1787351783;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNmr1ayQAvvric/X7TwlZcEWHDeDXUjRegOVWX5UQX0=;
        b=SQdFqg8xsuOJVBkfDUBpQbiRZ9Kg9l2P+U6YPsfScE+dHLf6vbACQEqK7e5BR/loCw
         4uS91SSniMCL5DK+D88NpCUjvFjguJKcY7T+GyfpOFOvGQporScnN87oCSDP6K7w3yF3
         ICkKyGtJO9Ng726dfhnEpMdaLEI+PzArb6EaMI7/3V6DNnMLp1G8ocYxBjAImx3hn7P+
         bqIZzBMz85ea8CA0aeXIuZhOn9437IHwSYtYn/uB/HDZBx7/pakaXTvWCmyQptW9PDLj
         a8jf3hqHzQZFssbSoiqLsVdwSJczjtkHH8oyqQohwlwdHEjNFbPkdvKF8gTqCfvUH6cM
         QblA==
X-Forwarded-Encrypted: i=1; AHgh+RqS4L5LylqjlZFo5TdIxBXZMrmskjPlC85ny4pjO/P2+tlmQzMvwrxzNb2bSuAtJ06nAOXTABs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vUubN/HMM+84ZWPAp67bFxbu80Umd+hkC+eZdx9mN/aiBsV2
	CUEqlqkHENXTgD4XE+ciubdjoqkSXme62L3yZuxSXe5BTz4VcQdLDwEZeGp3nA==
X-Gm-Gg: AR+sD11hHh8qpmAYxaj9PjAp406gFOBLxPKbW0JZym68QYstK62B0jiyZaMuuChAmZY
	R0MK3ZNKf9jv8YlScYBj9pbDgwlhL2bIvDhfjI+2w/mZp5b3mp+bfkU5r+Dj1gJCe+oB/u+Wf8e
	/ujX2I5/m2oRGtdxYSET+dP9YKmk0GQj4GZtvhpD3SOCJxhBG3sQs35q3MxGYEvdM/9MLYuO7fE
	cPeUJKea0XORrr+6eveuojPziu4p+7Q6zCN4Fc2Hvky5ZVNdsIK0oyXJ3GSLq6z4fDXVxH/bOSV
	ORrbrPUaIgGIrCEtcWjAlIkxkJsXLV5IQD5cpbeqj+7kTnNVSjpsuehgdVmPP2PGqwGCXw0hdnK
	SRixvZ09wSZ7ubQWCRC913vT4cSntdWuEsvxQWbIkI15PBtagBGY9ek7KKzESHvC+/A7r+b/vA0
	0TQIJtmbR2xu70EF8qB8NLUNlVVwgDaa+u2NwKzjOPhcKKxQVPcXlgH8qWqirisAKsPQ0toFCWl
	Y9dMvPu
X-Received: by 2002:a17:90b:4cc4:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-3933b927a55mr10641828a91.18.1786746983082;
        Fri, 14 Aug 2026 15:36:23 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b649975sm1818011a91.2.2026.08.14.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:36:22 -0700 (PDT)
Date: Sat, 15 Aug 2026 07:36:18 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] sctp: stop processing a packet once its association is
 deleted
Message-ID: <an-YYtoqw1QpTXUL@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sctp_endpoint_bh_rcv() looks the association up only when chunk->asoc is
NULL, and caches the result in chunk->asoc and chunk->transport without
taking a reference.

A packet that matches no association is handed to the endpoint, so a peer
can bundle COOKIE ECHO, SHUTDOWN and SHUTDOWN ACK in one packet. The
COOKIE ECHO creates the association, the SHUTDOWN chunk caches it, and
with the outqueue empty the SHUTDOWN ACK reaches sctp_sf_do_9_2_final(),
so the association and its transports are freed.

The endpoint loop has no counterpart to the asoc->base.dead check in
sctp_assoc_bh_rcv(). The next chunk writes to last_time_heard in the freed
transport and is then passed to sctp_do_sm() with the freed association.
The transport is freed through RCU, so this needs the packet to come off
the socket backlog, where the loop runs in task context.

The endpoint loop cannot do the same check: it holds no reference on the
association, so reading asoc->base.dead would itself be a use-after-free.
Mark the packet for discard in the command interpreter, just before it
deletes the association. That is also before sctp_inq_free() releases the
chunk on the association receive path.

sctp_sf_do_5_2_4_dupcook() issues SCTP_CMD_DELETE_TCB for the temporary
association, while the one the packet belongs to stays alive. A restarting
peer can bundle DATA behind its COOKIE ECHO, so compare against
chunk->asoc and leave that case alone.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/sctp/sm_sideeffect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 424f10a6fdba9b..94716406d602ce 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1332,6 +1332,10 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
 				sctp_outq_uncork(&asoc->outqueue, gfp);
 				local_cork = 0;
 			}
+			/* No chunk left in this packet may use this asoc. */
+			if (event_type == SCTP_EVENT_T_CHUNK &&
+			    chunk->asoc == asoc)
+				chunk->pdiscard = 1;
 			/* Delete the current association.  */
 			sctp_cmd_delete_tcb(commands, asoc);
 			asoc = NULL;
-- 
2.43.0

