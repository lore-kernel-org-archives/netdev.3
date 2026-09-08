Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDE55D869
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887952; cv=none; b=NpbMFNc93dn34jHcjjYLCLT6eWwSXlejEuZ7Kkn84cVYK5Bpjio4Wa4bmYZTVAvPAZmP3NUgTmNshVqmRjme2w8uEsuTDO+S9Z9x2fN2XZPi0g1GweoLKd/3SRxc5AqNGi7i2WAGOB4XZYorjTcjzvi6F1daPVvDO1+61KOEibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887952; c=relaxed/simple;
	bh=pSBJ0wuxuKY2n7MkyYRk/Tilh69ZMtqLinFYVMSY9U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0iAvAxnMnbxCmRYNhRI/hCPb0yUyjpOuoYwFXhkn/3JgH4YAZ5/BlMGM4OCLz/ro04odAbWnhcL23AHTy/6Ko8dkXwwR8GR6BDCCEjfLt8WG+3L6OnEDk4AWbDACVHmeyQV9ReKJ0AwF5b0P3rYMjeGySijM7NDOzJtB4SMe/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbkgEb55; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbkgEb55"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dbcb505578so48893177b3.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788887949; x=1789492749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5aDG6sDgF0mv/hfmJI710/QSKPFn+zrHlrTu7ob1YyU=;
        b=BbkgEb551OgcNtzwN+3h1Jfv9yaCeraLNcNDOIMuhteOxZ2Vebep11rHJmscl9JWAr
         x4wvJPEw/qyFeSQn1xqxQJMh5c5fagiIkHhJMfXGQxPOM4rg98jg1MGCAJgejFe0odlP
         vQCPFsv64gIelzhVIqgJ+IWY+vYJkE1De/4NF7goKCf7rQ47Y8mX22CHYDvXXd3fCHs/
         +zdoeNdolnTb0ZCubqkoT3biJ4o2xZ5rQ2O2lGVrd1lNqyvOzFBU6Nqab1Qh1iMqOgIC
         n38osTznOQ7atcrmg3w74kD9tuKl6NGUcAOGs91+b6ZXklqb9kxYn14ouDwI1AdCDSA6
         Kiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887949; x=1789492749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5aDG6sDgF0mv/hfmJI710/QSKPFn+zrHlrTu7ob1YyU=;
        b=TBtNx+ieyZ4bl0khyxwmgX5/K5K9Sg+QScfuefTb+ShTqgF34CM61SZJblZU9LvaGo
         oGMxFTycZ3KinucsSD0O1df4MHXR7RCGBmPzfqEUye2ZgC8eY46Ww+npvZAv84RRXr1n
         gODhZ1U0Jt/aQkFiXdnKkr3GLu8R8/w1a0o8+rjNbToCd74TYmODFX8HpBUN3f+kxzfI
         dAjT2ytmYw2456QMuuIpsNTl5jGyyAbI/uGAONeolGQSsJnwY3tjBLDGU/YOWyYgwdGO
         v5sZ+L5QdHgjF5PwyKi4K6yKs9BAx8kI+GCbKybF77ePoR20ukmUGs8W+AXjGYlULWq+
         a8Gw==
X-Gm-Message-State: AFuF++mXOQ03CRM/+dj/0z0jIDFal31r5SUXYqGc6UKxElQvCKZfcBJt
	wzO17Nq7KccfYkrZ2Afy9vMcPLP8hI2xBzpgfLBMi2aeb2Mo/tZHQD2EjPfu4oiV
X-Gm-Gg: AYBFou3B7HWm+eb/7nhoy4PIpf89x7l2zlNX5WDiO40ofRPOARPsc7KPGafn1Gj6Ho+
	624FnCtEgdrcptHMsMWdmrfcNPb/ByChTI7xp1eOWLkgPsGjByYU6y0zKJ/IH5/XxcSpcjVciso
	FMY/+7+MXB/iiLEKCiSHFYYPJbOUP8CQlUSAfjE3GrBJ8tAd977tL1hbKI4jrCTQhCawNneH0aF
	the6Z6igJgtRcOk0gfIB5jMK7XO0VHHhG5pOfZ9+r64CfR1MBXwThyo5ls9s9kwAEcc3ciyEY4d
	SX5koGGiOCSFjQ0m2yQEwhOVebMebYHfIkmB8YeujOAYfZb+ifV+C6Xj+86+lq0wjwtVw2qNgXB
	evLRkyV/BihBR2R7EmsGG4CFKulzaS6jqfWlPfRQchgY+usY+cImGcjX+iTvThXqqsFuy2gx1ow
	bR0qAEN2HikExyyZ9xbl2MjAHtBIzguWBfO/do0kEA0avjcRRDNCENAzI0rrmj4LrH5g==
X-Received: by 2002:a05:690c:88f:b0:823:2ad3:d392 with SMTP id 00721157ae682-871290a54d7mr102670407b3.31.1788887949335;
        Tue, 08 Sep 2026 10:19:09 -0700 (PDT)
Received: from houminxi ([104.167.197.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541c94ddsm120081361cf.23.2026.09.08.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:19:08 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 0/4] selftests: openvswitch: pylint cleanup of ovs-dpctl.py
Date: Tue,  8 Sep 2026 13:18:55 -0400
Message-ID: <20260908171859.1967327-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a respin of the ovs-dpctl.py pylint cleanup series. The series
raises the pylint score of ovs-dpctl.py from 7.69 to 10.00. Each patch
targets one warning class and makes no behavior change.

v2 -> v3:
- Rewrote patch 3/4 (docstrings). In v2 many of the added docstrings
  were shifted by one method and described the wrong operation (e.g.
  OvsDatapath.create carried "Destroy a datapath."). Every docstring
  is now derived from the method it documents.
- Dropped the ctact -> CtAct class rename and the parsed_len ->
  parsedLen variable rename that had leaked into patches 2/4 and 3/4.
  Class and variable names now stay as upstream has them; the
  corresponding invalid-name warnings are covered by the module-level
  disable in patch 4/4 instead.
- Moved three hunks to the patches they belong to: one f-string
  conversion went to patch 1/4, the bare-except fix and the two
  @staticmethod decorators went to patch 2/4 (the v2 patch 2/4
  changelog claimed the except fix but the hunk itself sat in 3/4).
- Rebased onto ab217fbb9b21 ("Merge branch 'net-sysfs-use-ops-lock-
  for-speed-and-duplex'") to resolve the pw-ci contest conflict.

v2: https://lore.kernel.org/netdev/20260905104026.3776396-1-houminxi@gmail.com/
v1: https://lore.kernel.org/netdev/20260513121240.2590767-1-houminxi@gmail.com/

Thanks,
Minxi

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (4):
  selftests: openvswitch: convert %-formatting to f-strings
  selftests: openvswitch: fix misc pylint warnings in ovs-dpctl.py
  selftests: openvswitch: add missing docstrings in ovs-dpctl.py
  selftests: openvswitch: suppress pylint complexity warnings

 .../selftests/net/openvswitch/ovs-dpctl.py    | 408 ++++++++++--------
 1 file changed, 236 insertions(+), 172 deletions(-)


base-commit: ab217fbb9b2169ce677b09a66558d5c3adcfbb76
-- 
2.55.0

