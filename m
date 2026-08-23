Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A137E5C1
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787450997; cv=none; b=jvZs3jSztBPmAU/ewJCCSO68a3NxQ8SR22XvSfvXfvnnvLxXY9k+YcMummE8VmDEbYT303MWcfmMPTb15CUQgjLXC9rHK9s/DfMHnsOrxVUKNb9knc7YVCBzR1NCJvFa+p4LkuMStx9lqiMMBNJvqkH3acuk6TMADI04RhGUZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787450997; c=relaxed/simple;
	bh=2cu7WoZVO4U5qTWQNLd3f6N6w0xjt0Up63T4e6lKG+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrbJ/Rxc9HxymhGHjGU8/TQ29qinD100ZfVEis7jmeTH1f3gZiCzDxZ1taYu3NV9joxWslZfCDPwhWcYPmR7DSQwyotpPf3xyrBDYPe6DYVrzsHS4iwAu3ZPHgjjxemJw42hEdqMNBjhR5V846Qn0+xQRn5+5P6Ngzmi61sSJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyKwk9RP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyKwk9RP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caea3f742bso36932415ad.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787450994; x=1788055794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CzKUGtLsldRAu0IUIgJKtLAkxGeLYC3EhzLHUx6XU+E=;
        b=pyKwk9RPer2DXcB2ARF96clbRYEk7LFXQPp7YsZX2LqDJYrD9pLLWg50xDexbN5VHd
         zW4J+sEWDWrT7J9DbXt3jOUXUSFsQMy8p13wowaAPktYVEIsbpy30c86ZhIB1sacBFHG
         jFvIUaaDCX2IT8FaQ8dO+T6p1df9e0v7aUaccNs4SIhUTMyNrYrdKkotR9DLv/cPNR1e
         jtjEt/oC78t3Lv4eRvm39tKa8n4IYqfKo7U3icb3jR9RJSAPZp7ylzbfNnc9IdmLGxwu
         UVAaOQKhU1xZUDhCXLn5/u/cAapBzAm+d1PT1oq4cZxDXmFZUnq3/E9IDeb7Z71blALW
         nInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787450994; x=1788055794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzKUGtLsldRAu0IUIgJKtLAkxGeLYC3EhzLHUx6XU+E=;
        b=fCIM4qKR0AoKt6PP/MdxMIK2B56e/fT45Ca6ITVuaNWRirUpgbWPSFU4z9MbpjbRH6
         885P96lHCmYs09/lGXxB6rK27868HHUu1p3eTLnLCdWxcRpPbqhEGDKW2ml8D90yDen0
         vgUzeARXb7G9rTr1QUOKD7pppYPWPnZHuqA0i64Yy2hILPlLutv2R9IZ0XCrfrvpIEw+
         DoKFmrxiQ2JGpza9Q56KP4lMW06/LqkT+IxJ88kQ52DNTqxY/LjrxFKfKJpN9FJuaqzK
         VfO0TJ+cEl+D0rxViNDomXwrJsI1lf5qF32Yn1TJLkoWQQy73xsv105PiH6FxRcg3hrL
         ZMJg==
X-Gm-Message-State: AFuF++mGDm87+H2R0t/u0uFZoIglUVmsGXzQczWGmtZ9JYdWcHv67gzO
	2Au3CvKZznA4SiVOp3Adspgz0JBrj2i8DUHdsMLNTtLyxFEo20uLZkAdtervM/l7uNp3wA==
X-Gm-Gg: AR+sD10nMF1oFhMiZdO981Yn72sfe0VlB9cWypfyvw5phiyWzvNqgFrru0iyWome8Oy
	BiD+0uZHzHhmVhcYnHR+kVLhC3KjLA4FKQZ9ibqO9DTySwwOpK9E8bqWWsKtdVG+hyrplszo+Ri
	i48JSSdMLTTZUuWJlUsBwtjAEz2n+IFdAORjgja3Xfk4Wt0ruIJO28b5VlEbfWqrGgM9oSPFJVw
	nOYdMrdAKLOXgifmp5DMpX5D8zoc8sRYqxpLjarUOpLg+Us3SgThHI2uj6inVLhWfJgeefLVf5g
	vNWLky7EaVIM9P60i/1C86/03Xp9iUkln7sYUXxEsNI0cP9+2TANP1SXX+NwgiKNIcuPqQVOMeM
	QQ2l8d+eNlExxumPwHwoO3SR9NNzXSsqMIypFA3dTLXd3H5Y7YysbHLaEU2hANuxAbzNGN9mQgJ
	9ZI7STj4R+xkKnCgKi0fTerFnbn+H286cbtk/1aAOkMEUe1+WKWduN
X-Received: by 2002:a05:6a20:7292:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3cd301c72f7mr25586751637.18.1787450994456;
        Sat, 22 Aug 2026 19:09:54 -0700 (PDT)
Received: from houminxi ([61.170.217.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm11371949c88.10.2026.08.22.19.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 19:09:53 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 0/2] selftests: openvswitch: SCTP flow key coverage (IPv6 + NAT)
Date: Sat, 22 Aug 2026 22:09:40 -0400
Message-ID: <20260823020942.3101898-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCTP flow key test merged last week covers only IPv4 and only the
plain forwarding path. This series extends coverage to the two paths a
regression would otherwise ship silently on: SCTP over IPv6, and SCTP
across conntrack NAT (where OVS re-extracts L3/L4 on the recirculated
skb).

Both tests verify the association and then push a known payload across
and confirm the listener received it, so a flow-key bug that matches
handshake packets but breaks DATA chunks is caught rather than passing
on the handshake alone.

Full OVS selftest suite runs 19/19 green on a freshly built kernel.

Minxi Hou (2):
  selftests/net/openvswitch: add SCTP flow key test over IPv6
  selftests/net/openvswitch: add SCTP flow key test across conntrack NAT

 .../selftests/net/openvswitch/openvswitch.sh  | 183 +++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)


base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
-- 
2.55.0

