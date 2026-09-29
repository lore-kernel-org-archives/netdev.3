Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC38248B
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653494; cv=none; b=q7+H/qPtJP26ILtEJ4drtaAGo5Ld0Yfk4OCQQ9XB8JzF3fxBMmlT19RqaOiBpVQ5BGHnmtGDcgpHm/yILB9JY+TCAeR9vatpx4f4olZo1J+oKp4Pjxjd2UcLVLSoLFJmS2W1MF7ZqD5mT9uSDyRiYR3gjru0PMlDPIKuFAKoisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653494; c=relaxed/simple;
	bh=TDM3wCQambpa9h21gZV/r3vaiCMvCZ21K7lDi+EpATs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzvHusyVQL323lyN2lYgFbsxlS6WAwInS1PvZF6y07VHCl2drKlXRqqxGVsE6+TNMSRq4/ycCbkbIstP11Dkzxe3g/HK8SkBwLOXKkjS00JpEaYhixuZKi4lyMLRKHC67YlZqHtCEZvzYcM7dxLvjXHhgFRyE3AxwhnJtBoPptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=Vi7ufYwx; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="Vi7ufYwx"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso1327953eec.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790653491; x=1791258291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0IB8v08XWNscfonnpFSiFr1o7sbmOTxmOYHcIF40Lc=;
        b=Vi7ufYwxm/+tYfZ8GsY17DZg5ZMGj3PYt+roZawz/BzdxxapkYvUEUJqucg4A8bcEn
         Dug6mwiIJZWVZlF+AvGFeh7lCSXuUjxkIghKaXvdL0rNI8fQGzc4li1HK5QDCipqk+MW
         DDqPjiSS0S/vMx1qqmP7PRyoLNcfme4OKmmMS6okolN0eI+YtybgHtmY7NErREdyXmxr
         nN/8BXsifTLNWbAnyF9K+NlIRvs58cg+Nf1mvElj0y3LlGLSo2DA/g0CVjbPkzBG6p6X
         z9AVKoFu5oFVO42iyopuh82KOA2EB7IJQskOeCQwpPJCOv0ZsjaAG2XurOWIPgAUOtqR
         hhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653491; x=1791258291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T0IB8v08XWNscfonnpFSiFr1o7sbmOTxmOYHcIF40Lc=;
        b=R7uYHBSJ+YjYqCLKRJW9VFVu6zy5TrqORKNmTwsg4F9aXPr12c+atpoEKO4GwTe+if
         zbw6ERcCiKJWajS+6AKXXXotbIgPROVNuwy7P4PFziipAFnu+3U9XBHPJ8Tfh4PTvTHj
         nwU5dNfGK/Pkb7Rz3xNp1NX5casypC7v1uomoOkzW+FNljCROBm3MtbvuTqdN7J12dny
         XvpY6CiT/BIVTYxqVrNS/61Q9d2L8cmqxgpg4vvfIgu74Gg4cLfJdy+Y/kH8x9RxrGCR
         Eu4BoKZQLR0AnYlgcusoGJSs/gMU85pbGJqEZ6SYTEafFuc3SZAueh/vWy9hvCBJiFzQ
         A3hA==
X-Gm-Message-State: AFq9FYK5Hs+JdCjtqO4XuX0dES0QSIhK/I/CpfH7sMR2OIRYevY6r1He
	q3cJOrdZsNj95Yy3SPvo2i15WSORD08V8Bi5RsDF6kyHabp3jNYD64tHnx8SeP72iVBSTpaCHN/
	RAjbSA4VtaaQoCcR7IZLVZFaQ3+aK2uW3s8L1mrUnVr8vgRCXkgXJ97FSvxHx2zMBzvuwPFo1
X-Gm-Gg: AYBFou30bdWUdcO8Z910qLYyKSCzfpyUapULUyVDuO4jWp/gV83RFNSpTXoUfEQh7e0
	JZ9sC9yRkYmaqzBZEC/bxwLm8hKUh1GT1hzRPCcBlI4Kj1xYRiLF42LXH/17F5n0c/EmcUSvH4P
	5EDs2ke05eFAKC1QDRDLFI4vDn4sHWqFr3WGKejEiXtoqTWZwvSFedYn6AaMu7LNtBnoycQv8VF
	kK4p73bw/S1d1+SPj4SJkq+qVP7jVyS0cb/izpX4+qZOuNeZQiknngYFtoL2TE7Fuq0IbHW0kB1
	LjVI3lbblREeTRIkErTKyxwt2lZnu451OHbFkKmYSpiyUqTKdei0YBvgQ0sHsNKyG5ipMlfuCP4
	0XSgMnkOjNYMdfPjxgcDXPWt7BpayPued1HoDwfH+OtIvviSqwfnW1PHBrSRjuLJCS0hviXIwHw
	rUeeEFg8B7fP3Aa68wwdS99QAfOGny5NQvZTDoFIUdgsDKfx193ypKlZmGa7Fh3SEiTrUlJ4wfE
	lyPQPPmpQo=
X-Received: by 2002:a05:7301:df47:b0:344:1bd9:1cf8 with SMTP id 5a478bee46e88-3441bd9213fmr7918757eec.2.1790653490512;
        Mon, 28 Sep 2026 20:44:50 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm51074824eec.9.2026.09.28.20.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:44:49 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v3 1/5] net: core: use the packet's L3 protocol for the GSO size limit
Date: Tue, 29 Sep 2026 11:44:23 +0800
Message-ID: <20260929034423.1967712-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.2f18198a6e1e0@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com> <20260928044102.1004310-2-wang.zhan@smartx.com> <willemdebruijn.kernel.2f18198a6e1e0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 19:36:01 -0400 Willem de Bruijn wrote:
> If netif_get_gso_max_size needs to inspect the result from
> vlan_get_protocol, call it inside that function directly? More robust
> and a one line change.

That's a cycle: vlan_get_protocol() is in if_vlan.h and
netif_get_gso_max_size() in netdevice.h, and if_vlan.h includes
netdevice.h.  The commit message says that.
