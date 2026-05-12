Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA03C3795
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619087; cv=none; b=XdwKon2zNSkO5kJtg4RHDAh85JhEW1vGKRBS3YgCyy0gcFqWM86d4m3KfuUs1AWIbKet2R1iVPAUZ+vtl90OhwhzdSWCOL7iiJTIHjI9Jteu2vNB0v/TS+ZvDw9PKb1KEx98gXX9qMBYYyKkhl5v090KLE7YKm9s4ARJO4lDY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619087; c=relaxed/simple;
	bh=J5gmNSPNQxxcqs8XDR9P+NOgy6ibnVJAuMTAtqZpUZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovQAGLI3wgbEMHCvJ/OK7EUbuDwD+uorchM7QDBTvQtFmEEMZ2HG8SiKT6/PkIcLsFIEUckYUNb8MiO2RCupqXFnoK828MmDM7rt9ZIYti151J1m2yZvEeczlEw+t8BnIfbbb7BOqdNgkcsytRX/LVmgd3kw5L2UgoZtCJkk/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKDuELNx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKDuELNx"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-90caad2e944so166579885a.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778619082; x=1779223882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpARctubxx8lA4XtZtvDCBF0ktNsLEKbeHjau0kupPc=;
        b=YKDuELNxPRrDXZRddMTCvxBXg7tuOMXxHNohdJP86e9wVCAjhJQf0FWbA8tMPE3TEk
         lRKj2tBaUEN1lrjuK/HrsJpEHPlT1YZqUJWK0puHJjVn+g5/GnI/oa3YI6/Al2df2f1E
         r0bJ17t477l3849Whf3YPA8IrqxYJspTaGMQb7MQdIKZzrpoKOArn25n5m3k8PYXX2cH
         TzKA58WKiCi9QSfjOBAjypwkiKq8tZK/+NXaggA94FUI+2Q1XYAfRksslU0WhItrrQqr
         +hYrX93WSpcUo1MOOaLU1iyk43fL2Nn8GZSBJEyWbFPNoqiveHZJH/KlL6lWwkllAUgq
         rFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619082; x=1779223882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpARctubxx8lA4XtZtvDCBF0ktNsLEKbeHjau0kupPc=;
        b=YuTK8t1LmyMAK3yQjrQEceZGjEwGo+n7NxqK4LFV7dESkrhwXg9KGxKC7oSDmWfxmm
         P5d5b70kz0f9/2R5TSpg1rPntiQ6u6FBw6zJwWokL6JOxJs2GVzwXfgkotL1UM0XZEfm
         c5kzKVbtKY9H1ViUXkOgUKDMXtGPWrBWXXexg943ixsdmfFn/uY7Qh5KRBI7fQNNEo8f
         NmluUq97nLXBCrDsevcQ4e7YX5Pni8NoJUvHSq/oHNqw/dZbQBYf7zJ3qQ8pUdLzTOSz
         XrsUDF4kp4SsYahf9xJQUqscEe2CkMomtO70rW/WTtfIqst5khEgYrJ8Oj7g2tIKoyoA
         UWyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+R8NbG5Ba8IItnEVDUl+GpPfkzGqNrFw1XokgQmgzJg32xUagKqXESSi/Rf3LWOhwHxLznKbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8dri4kXslv+jVtJ8kPpgfJOV+1CYwSnGmTeMTy8kdUFEjzhg
	H9glCNBUQjEetZ8C86/6oAFxQGxPxCs0R3hnYq3fzfw0p9wghPZiVpvp
X-Gm-Gg: Acq92OGtIqA1nrn7kTB/RIIJudrqKy3vB07dggBSfOLsZWasUba+igrpScumsfgr2Tu
	OWMYWxBcw/IRUJf9mAqruDR0rMINYPHVWNsxth2EhSmGDhqFnY2nZtmH9BkBOKb6x14I+qUK6cL
	dyH+yDTZhAnmgK4CUGCZA6I7G0Lon7NqEncBozN46uHFQd0Yfe19BzkCJnCMtGpzxd0oNbi9WK0
	87EyFr81yEGpYu5ug4XSCcoj4N3lki9v2MscAG5ueeMzIwjZ7D15ULKECxKJ2/OgMJ82wGwOjVM
	rTPE1x9D3hQoEzYKyRQD4bK/YUpw5z/UP7u9CJd3405FVksnK3d/NZyOlVACNMkVjZmdNpPiG3q
	vElWny5orzT9g8A/SLiN1vOzAjKy9FG/JauMh2akUYBjDx+N6xF0BIAMyLlyCst8KNqSiaUAkL+
	JB+caJn/IQdMYyKmWL3vbXPtnNlRTURXt4zZo3AW2+3fRBn9TMsnDlOY/8/W7HcxyoRM/s1ps5B
	203Iwg/zDrNZ2l3OlLlLQa/tQ8C/8dxdZN1LpZHZVQ=
X-Received: by 2002:a05:620a:7003:b0:8eb:10d4:a46c with SMTP id af79cd13be357-90facf9e383mr9443985a.35.1778619082195;
        Tue, 12 May 2026 13:51:22 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9eed0sm1490734285a.19.2026.05.12.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:51:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maciej Zenczykowski <maze@google.com>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] ipv4: ah: harden ah_output options-copy guard against ihl < 5
Date: Tue, 12 May 2026 16:51:15 -0400
Message-ID: <423b9ce3b45782c09a2fd9c65ad6674a9abb7c72.1778614451.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778614451.git.michael.bommarito@gmail.com>
References: <cover.1778614451.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ah_output() and ah_output_done() copy the IPv4 options area with

    if (top_iph->ihl != 5) {
        memcpy(dst, src, top_iph->ihl * 4 - sizeof(struct iphdr));
    }

The "!= 5" guard correctly excludes the no-options case (ihl == 5)
and allows ihl > 5 where options are present.  It does NOT exclude
ihl < 5.  For ihl in [0, 4], top_iph->ihl * 4 is less than
sizeof(struct iphdr) (20); the subtraction is computed as int,
becomes negative, and is then implicitly converted to size_t at
the memcpy() call.  The resulting length is close to SIZE_MAX and
memcpy walks off the slab allocation backing the skb's network
header.

With the preceding patch ("ipv4: raw: reject IP_HDRINCL packets
with ihl < 5") in place, an ihl < 5 packet from a raw IP_HDRINCL
socket is rejected before it reaches the local-output path.
However, post-LOCAL_OUT hook mangling (nftables payload-set,
NFQUEUE reinject) can still rewrite the IPv4 header after the
raw_send_hdrinc validation has run and deliver an ihl < 5 packet
to ah_output().  Reachability of this path requires CAP_NET_ADMIN
in the relevant netns; it is a smaller class than the original
CAP_NET_RAW path but it is not zero.

Independently of the post-LOCAL_OUT mangling question, the AH
consumer should not contain a memcpy whose size is derived from
an attacker-influenced field without a floor.  Change the guard
to "top_iph->ihl > 5" at all three sites:

  - ah_output_done() (the .complete callback path)
  - ah_output()      (the synchronous options-copy site)
  - ah_output()      (the post-hash restore site)

Behavior for valid packets (ihl in {5, 6, ..., 15}) is unchanged.
For malformed packets with ihl < 5, the options copy is cleanly
skipped; the malformed field no longer becomes a huge memcpy
length.  This is the defense-in-depth half of the series; the
upstream sanity check in the preceding patch is the primary fix.

A mirror-pattern audit found no analogous bug in ah_input(),
ip_clear_mutable_options(), or net/ipv6/ah6.c (IPv6 has a
fixed-length header and no IP_HDRINCL equivalent for crafting an
ihl < 5 ipv6hdr).

Reproduced on UML + KASAN: kernel-mode fault at addr 0x0 with
memcpy_orig at the crash site on a pre-fix kernel.  The AH guard
was verified by forcing the same packets through xfrm: the xfrm
state counter incremented and no KASAN splat or panic occurred.
With the preceding patch in this series, the original raw
IP_HDRINCL path is rejected before AH.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv4/ah4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 4366cbac3f06..8fa31bdf9792 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -137,7 +137,7 @@ static void ah_output_done(void *data, int err)
 	top_iph->tos = iph->tos;
 	top_iph->ttl = iph->ttl;
 	top_iph->frag_off = iph->frag_off;
-	if (top_iph->ihl != 5) {
+	if (top_iph->ihl > 5) {
 		top_iph->daddr = iph->daddr;
 		memcpy(top_iph+1, iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 	}
@@ -197,7 +197,7 @@ static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
 	iph->ttl = top_iph->ttl;
 	iph->frag_off = top_iph->frag_off;
 
-	if (top_iph->ihl != 5) {
+	if (top_iph->ihl > 5) {
 		iph->daddr = top_iph->daddr;
 		memcpy(iph+1, top_iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 		err = ip_clear_mutable_options(top_iph, &top_iph->daddr);
@@ -253,7 +253,7 @@ static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
 	top_iph->tos = iph->tos;
 	top_iph->ttl = iph->ttl;
 	top_iph->frag_off = iph->frag_off;
-	if (top_iph->ihl != 5) {
+	if (top_iph->ihl > 5) {
 		top_iph->daddr = iph->daddr;
 		memcpy(top_iph+1, iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 	}
-- 
2.53.0

