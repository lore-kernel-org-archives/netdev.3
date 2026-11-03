Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725153;
	b=EZZfJBiOvCTehNd0zZr85wRbpmshlKKMM7foMZB/DBPJx8Gz6mC/yfZ4ZX5mztMUzQwf
	 pYZO5EMUJcCfAztrf3v4XtiQe0DnXSlnCezF1kLaY/i6AAITp4sWHLja4T8JAa6JTP0tK
	 qkphom2i57KH+pLE70kpYZtu4VBuselkeAAMF/PJK9vWxMVegIjr9UrnvfkLUlQAKtec3
	 1koT7otDlMEQj0fyH0Au4XQdi+b5BVEOcUe/XvyXE2olkh/ClfIQQPJUC1Pj1xtDcxW6k
	 L4vhWhIsvG30G7QcYQc+QpFCWr30JJVRCN4fPAQhK79vLA+AbONq4LiEGhVpwgAgtow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N2nmgAkk9tKVW9ZZZ6y0Nm3a3F6PCdPuD8mrqugKq5U=;
	b=MLdINILCjeg7iuBIxhKaa0zsvkB3+wAp28MoL77KbggFlprvJKd8zUrwvg2BDFNpMDP6
	 mMRmIJ0Y8wesTcK3GkIHgiYn4KwnPOeciHoQDdWoOBP1Ee/tB8Ji5Et2rnuAXNaxLl7sC
	 0J89UYgFVqXQEPxARnz1bo7uszAPF4Ia48OWemNv6Xd4QkmFxavtA/brxmgTD8e8ZTHIO
	 +Ibe/94ZR7/ZIR+RoD1dMeoV0okjaGGXynn5EeF1gw3AqmMoaLesrjhUKXBF8FlnlIpQK
	 mFeBgkHXA5JFf0/Axd/ZVvx0UvslJlAG6TUDO5NHAhljKAj8zhGfnyNfxbRRg6jzE0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1password.com;
	spf=pass smtp.mailfrom=agilebits.com;
	dkim=pass header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=Z2SC43w2;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26585606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26585606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=Z2SC43w2
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53634b8328eso39406931cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1793725152; x=1794329952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2nmgAkk9tKVW9ZZZ6y0Nm3a3F6PCdPuD8mrqugKq5U=;
        b=Z2SC43w2Jegfalwfgu+2q/1oAUA+RXjVC6sKz/YdcFg4UC2x+XgGUs+2ttfIx/923/
         TdyxACU2F8UKQcE2sl3mLgvVVw/hKOoEYrDeQPuRcLkBkRsFm3B2i/KtCPrBTIQNu3tH
         T540yzoo+oQoP7XQHaclkUpQQ1a5vIlF4Pc28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725152; x=1794329952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2nmgAkk9tKVW9ZZZ6y0Nm3a3F6PCdPuD8mrqugKq5U=;
        b=T6NBcVUDu3/1ogWlevQ7wlc2BPm5xTD0Ytux5zmtNDvrKW7T0isI6+ng/EEImGsS7V
         +0xL5/Bzy0nmlJOXNbACGVR93PUBrmErY7AHYiVd56SIcGdtZtt8UNEBmsuC2ITe6dAf
         IblDhTR9B52bXGoNT4TsIkUBNVcNdLBq0NCLy03We5ZhD0szSKepXA5CRbhCMB4btVa8
         TxU/28L3XYLcGcE3D04ye0m8o9m3cik+N1LsSlS0gmVgzsHEiu9An0nfAQ297LlDAYc7
         HvZTzHoClChquq0OdsxORTQNt6dJmvZqtCKJiLpaQvPfzGs4PIglfuxspyqAO75nfLip
         /c3w==
X-Forwarded-Encrypted: i=1; AKwUvBwypA4sOwR+dP/ursjuB6TBtAk+oyYFlNld6zflmiYCCFXQ1gSn7iP0505gdHEJ/iDJGCiCIe8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Kep1ZWEO7uKw6Su73VMzXtNLipdv9B1IWgxRLplOGkRnB6eV9
	9Ah83lWuUpdVMM0/70+V1yfTjWvfXNBoPld7Paxzol1WchQnebnwhp7ZdvPlm5Yh35O5EV5r3hc
	FAkLTTPg=
X-Gm-Gg: AYBFou0Z7Urv63PhAtSQ9vqa6gjhitDRNik5okBSX2JR7Da+sCbEHdSxAIzQPGk1l/R
	t5gXHmBjkCwnk5yMcuoSWDhBYOrQ6n2Ac9/4iPiIsO9+Jrlha7exegYFodzKF1Jw1xBb3F9KjX6
	4D6vnbMz4gtsTF+FXtbYKOw/jwJiXCfmzxQ6N5At9GPMoPOAGw37e/Ui0I75p1TYfjACupgM27y
	YP/HOrgmqBfiRBq0sdZvhdPEUK4lGhrnyDFB9wzgX29aY6mOGmccW1IdqZjyKbLqeFKucnq3YjK
	hQIg/2+dBAgdxY/WebQ85BQzJPLoCt3DkcMN0Ju8oO9NKtNgZNI1398o/Z5J8MgeB5AjLQhdu0b
	sKUQGgRoBpmQUw2QWKWs6SQ/akkBefgHGhqS/yTRkxkudcIKiXuPOu/vCAJVK0Db3chBJBEA5kW
	b3x6pTn4WhITtl7iKQh0C1Yz8+KxN0r8qynVdfc24tXQ+NFW9hhP9T2MWRi+5eTQBj7zCJwsD0A
	8Dg2/XXXTjtlf6XY1F7UkRmZL29a5+PvlDOrerCClSqusCx5/sDq/C1q7zQRS6E2rVUtljLdGtB
	KxAksU2E9QsJF89tJzzKLgMQiOnP7xfghFrS2X6z+ZSZcA8vhKoZjPVGHJkae29Mu/IKhTQfIZv
	nAjctAw==
X-Received: by 2002:a05:622a:a584:b0:536:6ae9:f581 with SMTP id d75a77b69052e-542b8ad94a8mr237532011cf.67.1793725151850;
        Tue, 03 Nov 2026 08:59:11 -0800 (PST)
Received: from localhost ([2600:4041:59c3:300:a850:2af1:eb93:4121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca95caf90sm118485686d6.30.2026.11.03.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:59:10 -0800 (PST)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: ja@ssi.bg,
	horms@verge.net.au,
	pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	w@1wt.eu,
	Axel Mierczuk <axel.mierczuk@1password.com>
Subject: [PATCH nf v2 0/2] ipvs: keep templates and cport 0 conns away from packet lookups
Date: Tue,  3 Nov 2026 11:57:44 -0500
Message-ID: <20261103165746.39516-1-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
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

A template received over the unauthenticated sync protocol with a
nonzero cport is matched by data packets in ip_vs_conn_in_get() and
the protocol state machine runs on it. Patch 1 rejects sync records
with inconsistent cport and IP_VS_CONN_F_NO_CPORT combinations on
the backup.

Patch 2 applies the cport rule of __ip_vs_conn_in_get() to
ip_vs_conn_out_get(): a lookup for client port 0 matches only
connections flagged IP_VS_CONN_F_NO_CPORT, so templates and cport 0
connections cannot be matched through the out hook, while the
"update or create" lookup in ip_vs_ftp_out() keeps working.

The companion patch "ipvs: filter some flags received in the backup
server" is already applied and rejects template records carrying
IP_VS_CONN_F_NO_CPORT.

Packets with port 0 are handled separately by Julian's patch "ipvs: do
not create conns from packets with port 0".

Changes since v1:
- Patch 1: unchanged, added Acked-by from Julian.
- Patch 2: test p->vport against IP_VS_CONN_F_NO_CPORT instead of
  requiring a nonzero cp->cport. The v1 check made the
  ip_vs_conn_out_get() lookup in ip_vs_ftp_out() always miss, so a
  duplicate data connection was created for every PASV/EPSV reply,
  and it read cp->cport twice. Reported by the Sashiko review and
  Julian. Commit message rewritten.

v1: https://lore.kernel.org/netfilter-devel/20260925141115.16126-1-axel.mierczuk@1password.com/

Axel Mierczuk (2):
  ipvs: validate cport in received sync records
  ipvs: skip cport 0 connections in ip_vs_conn_out_get()

 net/netfilter/ipvs/ip_vs_conn.c |  2 ++
 net/netfilter/ipvs/ip_vs_sync.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.50.1 (Apple Git-155)

