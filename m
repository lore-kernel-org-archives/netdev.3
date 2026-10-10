Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95033F4138
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627046; cv=none; b=ZXXo/1xqINndm9xfAxqnLVdQtARuXs0abaA964s8MJ46rrhxeGA0WkIh5oz+0hQq/pX6YRnXi0ZEcGn2FmChNT9VLeS8WA9pA4XBOTDsujWo/ZYP0MTOOZC28y1plYLCoNXQVPTAAPGGDPjDrYsaT6UiQ38spypuCEC1d3Qo1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627046; c=relaxed/simple;
	bh=k5qXWm2fWfprmVvsRKBjYWJGJEhMZpzoHtTJXsDkYxc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M2iknmLWoHqIZC32MDk031PvnR+QrVWQMR7cqXo1eRcbJqeT4c7+rbuVRH4njcOlFN7zfR7OpaktvzTDgZQXy/AB3Oe3JSBCyMQ5G+LbhV1dkkC4GWISm4VF67QWP+pYBivxtR3MIU5XwQMDR2bJ+UDiUe2ouoevolPktOLMp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ/Da0n2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ/Da0n2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-884062f3296so332639b3a.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791627044; x=1792231844; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6g0pW6yOR+NxDMtQhXgsc9e0vnz9TsV7kL1lDEnnCt8=;
        b=XJ/Da0n2QZgfmg1l98fqDbR5o+Y5evlJueqGCnhxwT5dwkBMPfEO0VzYErlGlwnIcY
         r3B55ZertW/FUcqbxlNYFoqxEsKvdmyfmqOG/qNy848oxTZIEbuNVDzuvfoSgutIh7du
         noDVJw7xZbHKe37rh0/R/fQFU0/2IVIFT2Bw1PFiFhUtFwz4nUc2Bj1XgvvSx9HQY8vI
         2zH6NY13pNEzGabNW97BFFgDWnRbtUx9TIoQw0Ulx0rqE+Gf+g4rTpkDiIUEd/2F8TBQ
         MAhtjR82JVZgImtAFfVb5IKS4xGspX1qPTW8MuHJ5SOltxvQOznqicE6JIjM6+fSBhM5
         xpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791627044; x=1792231844;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6g0pW6yOR+NxDMtQhXgsc9e0vnz9TsV7kL1lDEnnCt8=;
        b=KGY6OYXKNaQTWFS9Ee2qSTm3YnZs3v4aCA0u/1tHZJIVQ6MnQAaIht/A65ygl+vVjf
         ikgEJiEnaPUxN9yP8AD5Ehnop2MudStN0tyyHwoO9Ac7vkWZ19Gdg+PWGJes9ajPeCKn
         86AzRN04m6b+ZqSnw10sas3KsejTiSMhU8bsxz7Pp9nFI7rwVeYOuXHse61iWniS23y+
         7Xk3Ua6cPWsV6tKLQr2hsDnSmWpn10GUGrcTsCbrLKRY2fgIProlgF+GiiVOYzCAuPKd
         v4wDTRZqoRqadVa5sNweko4fTyoRYn4C3qZ4jrqIpcQc0Q/WQ9Azza2cdcbe3AAGSEA7
         wx5g==
X-Gm-Message-State: AFq9FYLsVymlTuJ1whTihtSwpRn/auj/RB8uYy+drZ5AA7CHw3afvkSe
	A/aCXVeyh6dyZJ98ZzPKQw3XSEXIQxbYlJRledEYXf9chGc3togWy/AF
X-Gm-Gg: AYBFou39tyBFrgOmuqTXTduHYHg++/Fwo/s5PnlzcwefjZnFN4y2s1eK3EyVH3uEr4y
	QaTvEv9hC0MguD/0m4uoNyeTShrPfZ0y1Czt69vsVcIeLdSgjFP49laRMGSlOZ7GY7wbk4Xd6f8
	Z4+thuVv8GOoKEE5vFuatIWq9cHILGQadRaHVXvjXvD9mNPEz+8/+eruVpEiyV6MSMA2hjVWlQR
	OcjJKiI7pW25b8pw2N4iGQfKiAnAf9cAna/la0lxaFkfP47TnPYUhzTQs6A4uF9TB5A/pVOmpQr
	uGepEtGYI5cMBhlGHU2FDtwLGIJhiJJiklnqwLaMTWfsSo/O521jaEYgVoNMmc2+ktUrSILdbdJ
	y+oAsi5ZNf38MHWpFhnU1KtFGmGVmF83nXh5McPIQgZwDP9aoE3eK4jpVh/ZGHh3ovi5/osrtNx
	dshx+gthLc+uwIF3oGLKxbfhOf9PazjEkk2s/0VEAZAIUdDiUq+Wb7i0eAtCKULaJ420h9gWMKS
	PWghTswVw==
X-Received: by 2002:a05:6a00:c488:b0:899:915:792b with SMTP id d2e1a72fcca58-89909158069mr699050b3a.54.1791627044073;
        Sat, 10 Oct 2026 03:10:44 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c37de99fsm2069988b3a.25.2026.10.10.03.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:10:42 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH net-next v2 0/2] seg6: skip route refcounts in seg6local
 lookups
Date: Sat, 10 Oct 2026 19:10:38 +0900
Message-Id: <20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4PymoC/22NSw6CMBCGr0Jmbc20KQVceQ/DgscIVWxJWwiGc
 HcLunT5P78VPDlNHi7JCo5m7bU1UYhTAk1fmY6YbqMGgUJxRMk8dYoN1j6nkRnr6M4IuZJFWiu
 kFuJujKZejs8bGArM0BKg/CZ+qh/UhP1y7/baB+veB37mx+JHSv+QZs6QYSEol1kmKcdr96r0c
 G7sC8pt2z4WX4mszgAAAA==
X-Change-ID: 20261004-seg6-lookup-noref-e016495b60ed
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=k5qXWm2fWfprmVvsRKBjYWJGJEhMZpzoHtTJXsDkYxc=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqyg8fEnSNrfVB5GQhd3JgS68idorn2DXSxaacs
 H0CA4NtxXuJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCasoPHwAKCRAq19F1Kl0b
 TfQwD/92pg3UJ9YHYpdH2l2U8XFV0OESEB1deZ/0+avPoTkMzadPjB3r5dhuwJoGITN/O4xB54v
 XU59rheW+nWhwdTrsj18L1Tg/NbGvh7dUWf5xR4/sshFt3lBp8jcSAVqbeWODAQNwwb9Mun4VeO
 7tMq366q/IjANpknEypTPmM8RyxGnTm5jmdWNnabYGBKGnlDEs18xJh7bhSYlnCWdwHGcOI3FID
 fr/IEtROgO9uuQW1CJC4i/61THAJt/01DhMCA2d4Lyc+crLoJdPO2AynNtD5fmHHXKxjp5oP4tD
 U8Vs92iMSJKUUcvGfwmgXdh5lmFWDZ9NR+D+Q2THZAgLLqf9eQ85SsM0HG6YW1kB8bIEytzgytt
 0weCLziXloGeyiPPeg1GumMtY1y5lPctWJxdkF8ntVshFG7FXkzNdlUmlJgFfrtNUUnYKeX3l08
 DA2Isc1gj8yBAtKOEDULuK1e9BojD/wB/S6grVQwJMttNe17al2divyheggIkOZta76laaQxHTs
 5m1kOeGRhcP23BsgLAZp1/jn6TURRwCIIf2zl88clht7DSA0TpMdCHnQv1gnBjJRi0NeNbbp6oB
 HVXuc9/CoYa1PowD7LR5xPGVtFmLdkGwRhV6WjCqvVdfJeZD8JB/dn8qVXBFZ5Uw8DIBfA+pA2n
 PPlGAVm31ShlF5Q==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

seg6local looks up the nexthop of its IPv6 and IPv4 behaviors from the
RCU read-side section of the receive path, yet takes and drops a route
reference for every packet.  Skip the reference, as ip6_route_input()
and ip_rcv_finish() do.

---
Changes in v2:
- Split the lookup into a noref primitive for the seg6local input
  actions and a refcounted seg6_lookup_nexthop() wrapper, which the BPF
  LWT helpers also call (Andrea Mayer, Sashiko).
- Rebase onto net-next and re-measure.
- Link to v1: https://patch.msgid.link/20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com

---
Yuya Kusakabe (2):
      seg6: skip the route refcount in seg6local IPv6 lookups
      seg6: skip the route refcount in seg6local IPv4 lookups

 net/ipv6/seg6_local.c | 58 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 16 deletions(-)
---
base-commit: 758fe10f83a655bed0f7b98fcfacdfc3556fb9a1
change-id: 20261004-seg6-lookup-noref-e016495b60ed

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

