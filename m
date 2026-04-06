Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F46299AB1;
	Mon,  6 Apr 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489667; cv=none; b=KEl1O0KZR4XzR1l9vLc+vQKgc+HEtr2zWlJZSmWt1U+ojMzO+NqQA5RLKrQFEiyUZvGziVnNU7+jiJ6URPfo5lzOhSdnBTL0tchvuDeHdwRQ97bja6Klt1/RYeMqW2R35s1nNiBORrbnlcQhGo+JQ6icE4hPu32xo+gIZhm+b5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489667; c=relaxed/simple;
	bh=cNCahDaYMNRIRA+ToSgIVNWhfzsNFE8w/QkbQSScoZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKsVBwzJcFAWmlkwHkUT9py/FeYPl6PbwPoXvCtNRWwJkQBOxtyFIcBAkEh3kEBTbx/IfQhJdUQwJqpjV9JJCdfLVDtSsNCTnK/e0kY1vyfzbPm5BkVodnIu7YgfecSW+oWwyp94Nm9lbB77FZXI1cQE951jqaQIMEAC8vUyGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBiptwh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBiptwh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC4AC4CEF7;
	Mon,  6 Apr 2026 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775489667;
	bh=cNCahDaYMNRIRA+ToSgIVNWhfzsNFE8w/QkbQSScoZc=;
	h=From:To:Cc:Subject:Date:From;
	b=YBiptwh4GfReMjDOT/s8oQR8uT7zE09T4LGgCDfXUVZH3vCPV7P5KombNPdvCGSvk
	 GAJ2DV+SdVLolw4YUZkiwcKoSBiwhQ9jlgIMmaeBjPWmunNXgFc1zbkFp7oL+0Z8f6
	 ekMuHu4FbSr+4U+2ceyqEcV5lfSfT9n1S+xb9TpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] xfrm_user: fix info leak in build_report()
Date: Mon,  6 Apr 2026 17:34:22 +0200
Message-ID: <2026040621-poison-gristle-aaa3@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=cNCahDaYMNRIRA+ToSgIVNWhfzsNFE8w/QkbQSScoZc=; b=owGbwMvMwCRo6H6F97bub03G02pJDJmXL9UeNT0qsj50iavmvDOmm2V6j68/eyVE40d7UrJ6i /mywy27OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAit+sY5gc/StrNmbK9Sa62 NfvURtZN4Ut21DAs2HN4cbbM3gcHl8lrsnCGTKhi7xfoBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

struct xfrm_user_report is a __u8 proto field followed by a struct
xfrm_selector which means there is three "empty" bytes of padding, but
the padding is never zeroed before copying to userspace.  Fix that up by
zeroing the structure before setting individual member variables.

Cc: stable <stable@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
As before, I _think_ this is right, but my code paths might be missing
something where the whole buffer is set to 0 ahead of time somewhere
else?
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6d7b5bb2ec9e..1bb8d05561df 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -4117,6 +4117,7 @@ static int build_report(struct sk_buff *skb, u8 proto,
 		return -EMSGSIZE;
 
 	ur = nlmsg_data(nlh);
+	memset(ur, 0, sizeof(*ur));
 	ur->proto = proto;
 	memcpy(&ur->sel, sel, sizeof(ur->sel));
 
-- 
2.53.0

