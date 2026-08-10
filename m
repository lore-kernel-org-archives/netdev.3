Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A529C33F
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376856; cv=none; b=tl+bXxB5L9vbr4hT7bd2LLE0qaZj+EonK2QuZCzMcRD9VQtHcSHDr6SArVwZNcX9Hmw+Ac1HI4UfxAeYyRbZB7bZDYLbwErVCymDaRuK+yXnkk89GRKtagGNw1ezqo97sR6V1MJLeGiCBH/Ky/v9DXR4e5t+PW3VybfZWO8h1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376856; c=relaxed/simple;
	bh=wOmW7m7NE03gMf7iUofQ0pKee8XEwyElqjWYwIQXPWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fi+DudUGf9TRxSesCjKhx1QNwoigKPQSKJTKHGAfCv9kEL8icFEViQkY4/7SQTMhTMNTH/B6tAOOcnjK7GkjZZh6Awje1X36bOAXDs73c31mrRtvrOuNYlmjeTIZNcGO4M0CqR9IJd/bLxyGAbf54woZZsXPpt5onwxvvZS1rGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=KIQi8RyJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="KIQi8RyJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2808dbc3so12519101cf.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786376853; x=1786981653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cz2j7Ub+YNraWKHWXqt2U9IfnVOCLgD0ZKsDhgeBKYo=;
        b=KIQi8RyJZxiiVqMbzgtZzFkUc8jPDiwIasq+ZTX3ZLxiC9qhjZqifarfla7u+Nk66W
         pcVkHOnO6fUPtXHEuFdcA2mkW+NtQfVnI+IuANhS5XEKqVxIP3iacugjNeZejOAtvT96
         J5MwH6cMUCCOcmo6r930pJgSsf8T2bYuqGdYL0jfiRjK7LigWj002AAqUxhKHIEPboqa
         Ihf+Ak3RKDcqovtqeZuuyzH+4P8EseWWWMv5Q5mofGXq4QsfwHPr4d4L3Y4Uld3Cl2Lr
         jyWWLfJQVumkDCSsvXfMYhixwipIsZqm21S4ZpO4k0Pdk+koei2/eua+OXaL5HRhImGz
         GY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376853; x=1786981653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cz2j7Ub+YNraWKHWXqt2U9IfnVOCLgD0ZKsDhgeBKYo=;
        b=mwmy6p9OlmD49tawwy+ontko5h8lBaFYqve5da8amve912nIwMa16YG4lBhmpp45kF
         u8b7npzKbVQQuYet30CZTkbzlGO32HR0k/oVeQJjsw9pHmKhoYo68Uy2yocmN2tr4Vdu
         mvn0RmSzfUJVaB6nzCAlziQ1OOWk7mXNJcptHv0vwV4DgSl4AVfkG9O+BZeogeDIKw9s
         +m3D84TehTIsSbQpo0o8iF0frc6Cb+A7RdWgM1WxuANA8H7BmzKg5dCAd+rwWhbR97N+
         PAAhlF6DSQiN5QD6LHchH+KRGiYpJOFe/2qkm+ESYSQucK/TS7ogDmHGGSCfo5R5F0rj
         TYIw==
X-Forwarded-Encrypted: i=1; AHgh+RoLsa98YK41Wedxx+QTbNpU8JX3+QEi/mhhgO7zD4YfyIVk1UZXHrBHPgTyDC1+d5/TKroJ1cE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+I3d7AZgFQawFixHetM5w0keD7PlZOfwoMXPvpM8dOwjBYMXX
	nF6ofvknGCaiYhVtxf2bwrzStr9cu4gDmFVLB8uHMnOAKtibjIKc4JrwJ9QCQ0AbYow=
X-Gm-Gg: AR+sD10sMy/wWX+oIDVrErOB8rVbZSD5PNWoOdF76y5veSzz767S6UG7Uz4Ks0QUmD8
	vZ7JGmgn1NIA7+5tHYZB7uIOCJ0ABHEkfAVpLf5RYDZv6JbSWh3a9fe8KZUVvGyBhoEl2sH8noA
	TqBEb/no4qt9qPZORhvRme4P3vDO8bATOPWd7XCuxVCCOtpABahJsTb8pLVFileRHwk7ZQLQqHa
	Ax7o8V0rnLb2z3E9zgxtn6PHHaq+BAAAhEtTpCwrwT++PqRDQSCEDS1dgumVQV+rG1si3oV+Nj4
	F+dCVk4LAfqhYsrs17KKeJ93MCTDXqQ9uzO1QUyFzv9QPq338zueqJz+dWA39PbsRyC9SZ4Vqyq
	NmdYMhj2meQYcqklLaSXcjbJZWcpekLIG2hOGFZObEUfD40rQOK83390kFVXgoksXhhlk9AiWVt
	UOnHhPU5C/2QJAQCtReyXBYppTb/tL19IGWiXoLXP0MWc6CEwObXa1d0ls+sjudQB08g==
X-Received: by 2002:ac8:5ad3:0:b0:51b:fb4f:afdf with SMTP id d75a77b69052e-52ce5f612dbmr458618171cf.9.1786376853398;
        Mon, 10 Aug 2026 08:47:33 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52d1637f4a1sm74972291cf.9.2026.08.10.08.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 08:47:33 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	horms@kernel.org,
	stefano.salsano@uniroma2.it,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v3] ipv6: seg6: clear IPv4 control block on IPIP decapsulation
Date: Mon, 10 Aug 2026 15:47:31 +0000
Message-ID: <20260810154732.850472-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

End.DX4 and End.DT4 decapsulate an IPv4 packet through
decap_and_validate() and send it directly to IPv4 routing. The inner
packet therefore bypasses ip_rcv_core(), which normally clears IPCB
before IPv4 interprets skb->cb.

The skb instead retains IP6CB data from the outer packet. IPv6
extension-header offsets overlap IPv4 option fields, so IPv4 can treat
those offsets as saved option metadata. __ip_options_echo() can then
copy beyond the allocation for saved options.

Separate End.DX4 and End.DT4 reproducers on the unpatched v7.2-rc5
kernel both produced:

  BUG: KASAN: slab-out-of-bounds in __ip_options_echo()
  Write of size 255

The End.DX4 trace passes through input_action_end_dx4_finish() and
input_action_end_dx4(), while the End.DT4 trace passes through
input_action_end_dt4().

When decap_and_validate() handles IPPROTO_IPIP, save the ingress
interface from IP6CB, clear IPCB, and restore the saved value. Doing
this in the common decapsulation path covers End.DX4, End.DT4, and
End.DT46's IPv4 arm.

Use IP6CB(skb)->iif rather than skb->skb_iif. These actions run after
l3mdev processing, which can replace skb_iif with the L3 master;
IP6CB iif still records the receiving interface set at IPv6 ingress.

Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
Cc: stable@vger.kernel.org
Suggested-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v3:
- Clear IPCB in the common IPPROTO_IPIP decapsulation path so End.DX4,
  End.DT4, and End.DT46's IPv4 arm are covered.
- Preserve the ingress interface from IP6CB instead of skb->skb_iif,
  which can identify the VRF master after l3mdev processing.
- Update the Fixes tag to the commit that introduced End.DX4.
- Include the End.DX4 and End.DT4 KASAN evidence.

v2: https://lore.kernel.org/netdev/20260804094625.715305-1-david.lee@trailofbits.com/
v1: https://lore.kernel.org/all/20260731140832.567669-1-david.lee@trailofbits.com/

 net/ipv6/seg6_local.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..95ea0b62729a 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -256,6 +256,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 	if (iptunnel_pull_offloads(skb))
 		return false;
 
+	if (proto == IPPROTO_IPIP) {
+		int iif = IP6CB(skb)->iif;
+
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = iif;
+	}
+
 	return true;
 }
 
-- 
2.53.0
