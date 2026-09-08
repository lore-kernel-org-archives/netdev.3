Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1523C8A0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846413; cv=none; b=cnECYzFlqQ7aMzOrLtHaLuFs+U1oHVfXOCq3i3c6GZ/pFJcgGfTQCLDGaraQNI8DuB8GOW4e/fSNzCrvBSLJJeTnfiL1Y5NiwUyo14OJeHBCHvtwZiO/l1Ksw3c7+XhV1WJP8k3j/7TJI6hb0tv+JkgCrsUaWfacmTpaipulu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846413; c=relaxed/simple;
	bh=EuhR7rnrXb0BdM/v3vGX5RjwAhgOZzPzZOkDquDHEHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/hOuWQpOU+stgknOu4D566BjQCbwEMgw9mw+H3/DVpNjEsTfPZOuAIT2EaUbac1bZGtl++P90dFJfCCxa7dFzI5SDW0zuuPNO62i8oGEnT1YT3UGtg2AztdaIkvxzvPXfQg41uci8Fygo01s219nzGols9hB/TopyqBTMsRgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6hjR4/5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6hjR4/5"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso3479677a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846411; x=1789451211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
        b=T6hjR4/5O+GCrB/PY+p0heo7CJveR3odWnN0odsVmiJOwt9yt7zkEGThHBHp8wJtIO
         aFZNNPjuF2KEkLBXFDq3IrcH2I+ZnLCSAr6o1jzo2GAXJUJNMAmCKmPVYazKnSsY3sqY
         xCMwTLODKZRLxuPs9QG9cB56kANcraqXD53kq/FQycqo4DHDYvAouKpSV0fsilyX/OUW
         2MwBR/B/wHjDR9bvF0bNIxmkjkFqNvixl4IB1Vwzz1MHkfKCzypJLXIanjOIe3GyLxY/
         30OEyzMK1TUTHecc5ahwfAR6KNv58nSJ1h+4Vc6be2k0bm417NUuUhnvtXeuI628fykn
         1fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846411; x=1789451211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+9kcEfU+zg9dMswCCCtsz8ghn2YtDfgBRBD9i8GdfQ=;
        b=swuwJOpqQTPN57Vd1OWl9b5c9cbtYPBEOdwTqU7r2TBfhoNoygmbId88zt9p0TjEEX
         5ABC80w7ZabzMB5bIv2rmEaGNpbZaFZIrELtGE+m97mXLzFcKB0pb6lOb4Ace53juTuI
         CQW31a2BZEhIHwokABSFC7NZ/hcudL+Mv+AXxoF4ZcrkTGIgJqXS6py7MYLLWesRvkzB
         WCgi4+pgOGF47UWyDDxY1GwuBNLL7xV0Wmxw5AtD0H+VCY9NNZbBwXR1w4blfUv/azmn
         vQ60frbi6YG9zD2SQT8Ky6SoUKa+4oi6GEU8m/v+WD7npuvgJzMja/yPcbHOdKxttqz7
         T8kg==
X-Forwarded-Encrypted: i=1; AKwUvBwHqmWz2kj0lgfViLrUDBsI/ThD9hI+orEBMa4ny/GOmWnkXiSQAx/DMvCMDeIWt1ujml4M4Ls=@vger.kernel.org
X-Gm-Message-State: AFuF++naR1qmqCE8w911oCHvc/TmaGa/Iv7LEf15XfgVgyCgNBdVi9Fz
	bO7x8K5XyZLjshns3bb4KTBEvzK+zPiKm7F7HrTVkSCYD8e9AoATKBnp
X-Gm-Gg: AYBFou29MP2lwvDqOdGLgsLFX6Al9Db/U0Trm96mF7kM1S45QD7K9N+ha9dgpg+ximO
	sFSJ0Nx9rwogyYM8gjN/p4iefB2KNIfq7z4Pv/T9oJrOJb/47kOZ+Yp+imNOHpekzR/PVbWuTaZ
	CFWIlK3h4PrwnA60gq5Za9qswXw6S2WzGEELqH7DnjoRa+bnlKVjZlENbaVMHTVuPkx8OU567TM
	4/xUwOyvJU5UsOv6ag1LhkqNDALw5b+ZPkQmKXq9UL5E2MSkaiqFUd7TTrfQ+heN/RYf6mL1hBc
	R9v2vOYhWP7OBpc7UTfsWA3DUEwrs6W1bqVPUqwf7fmyKvVF4oovQy+bWFs4DD7kpG38hS23vRH
	mFibYlUhw3LzkyR/DKnenxnhgckG0zEgamQOoCnhMIyIbvGOhkakTwU61PSF4Fpfl2RQKNe99//
	VJ9dZ75Okc+8lENz8mkm2xCqEdroCAebRwO1b8mw7lW7ss0fc9GqPSt663Iq55cbEfhgSwPr1Yh
	WRcQ5Dx0V0VnpT5UxrU/EnT
X-Received: by 2002:a05:6a21:2d05:b0:3cc:f9a0:3ada with SMTP id adf61e73a8af0-3da215a6cc6mr32295410637.16.1788846411208;
        Mon, 07 Sep 2026 22:46:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434c745a09sm2053384c88.7.2026.09.07.22.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:46:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
Date: Tue,  8 Sep 2026 11:16:43 +0530
Message-ID: <20260908054643.11460-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
References: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 10:27:00AM -0700, Randy Dunlap wrote:
> How did you choose iwl-next as the target tree?
>
> The closest match to that in the MAINTAINERS file is this:
> INTEL WIRELESS WIFI LINK (iwlwifi)
[...]
> but the patches don't touch any of the Intel wifi drivers.
>
> I expect that you want net-next there, but I could just be confuzed.

Sorry, the prefix is a confusing one.  Here "iwl" is Intel Wired LAN, not
iwlwifi.  It is the prefix the Intel ethernet maintainers use for their
next-queue tree, the one in MAINTAINERS under INTEL ETHERNET DRIVERS:

  L: intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
  T: git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git

Intel's own developers tag patches for that tree the same way; recent
examples on the list are the ice, idpf, ixd and libie series, all
[PATCH iwl-next].  Since these four patches only touch
drivers/net/ethernet/intel/ and its documentation, they go through that
tree rather than straight to net-next.

So I think iwl-next is right here, but Tony and Przemek should correct me
if they would rather have them another way.

Thanks for looking.

Hemanth
