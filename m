Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0C3B27DC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763539; cv=none; b=QsIks6MsQdRcDC7pZ+wDcDSMfYJSz7XBk+1UbFbqcNf0LCkL3zAHj0WByeCM1Mzi6ezw31UiaKWKizI6vfW7ZHwLsCBr+GW3mwNPsRwl4wpJeQqeAvWgjOxZ1WPBez4bAeP7z5lQFdc04tePD18i3oYxXwnGqHOx9gtgD8FiAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763539; c=relaxed/simple;
	bh=Lw08kb+Yi5NRfZz8sddEr2h6szXqfBbP+Va9h6leGXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAohBBJedGRkNuyIBE7kwH3dAlSLRkbX9VNb799REvqT+2TqG/X1hKuu70SBij+UgKplQv9QD/YiNK0308FtL2ULwTjRl9BrJ+3cjLbp3GB292+Qm+TxjJcupqwLe3W8v/vKObRauZMKdghNb/yjo3rcpvm3xLKEFp49ZdffRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGVETO9P; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGVETO9P"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so3475167a12.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763536; x=1789368336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
        b=sGVETO9Pcy94hbBV/lSu98SBburfQdI3F368ejNrm7znJG8vkU4zYqTEN3r6mdbibH
         XbfqmvjgXpEiPLPX9uAJj6oxVhLNlJGrvcY5sJUKViU+P6KfzPBCu1IBk6L1+Owr48pt
         RWcemShkoI0WPbRtIxOyMlzaE35PjFDX0D+HdGGCYmMA5nfX1Tk2XjJSAeG1OoEAHTIU
         iiDOv2CC+1VITk6FaIVKzfsRD/FJmMjpk3GoBiSAZFanhT7hed1pSRDLYc/egFf63B5d
         kekVNYoPT+NmYGPrryW5mAfucTBCW+URXYFgAqR7p0pmPq8WIuKl6jFQlbKhwsSAnDxd
         Cv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763536; x=1789368336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tGB2PSeXN4lh0hUHjCdethGbqU/tWfxT7AmYX0+4CQQ=;
        b=pJ6u3N4hsvqE9SGspl2OUSm0zcQjJgAwaPHdCZ64XJmCYWIsBxLBenw1WttMqTezuk
         iH5i4at3xxU3vGcrJvYDRIjYxfPFq6foa3RHQtuWCpUFBhxMFFe466xa2XaC5Rdmb1CN
         fD3zvuYnLeckvEJbJY3sTQFkwd6PstyyVNOSLkBbFpPNzSM1g6Iat3rg2hvRom6LvtsL
         RF5rB2W/SM3pHF9hjlWAlmgHv83XsxRWsQAK3uvWFSFlll8dOkjR5s3S1bd195mtLC89
         FnZhzmqpx7m2T+ow6yMm+03EYhJAtcsIAt693KohhZMDGF6zVw4AmiETkYIfmoyyKa5L
         W9NA==
X-Forwarded-Encrypted: i=1; AKwUvBzSPonhNfatN5faRnMxUuhu3shKVCUGITqQzh+o89wgURwWHt/ysm2VY0FELLy54waFZ+Ho4Xc=@vger.kernel.org
X-Gm-Message-State: AFuF++k1D0/jtttJycMkfpIGrD1ZA9Haz0fOkz/xryJiDxiX0B7iQY1D
	vuNTavC8M/aGBCeRwAVTzSFJArBL7Tj7drlcf0/Z68Nzh4zReW3j2BXD
X-Gm-Gg: AYBFou3sWW9OqnmNC+gcWCDrHwnJRdmfmXaxwTLf3Ns6MqtLRj+eOZjOVfeC4kvTq+W
	h6i7fGRJEqQKXs+9RxDtSjCq7WB/ZHdU3bJ1lM7HRB7jQ6eZZVCSkP8Wrjtzwd9iSF15sKvk3/0
	tZ3h/zaxkcU/ztKBfhesQFJXGYVtXFec9PiEwlODJ1B/3q+a7TgC5eyxulLTtz/v1D6o0CAheI4
	DOBjTF+EzBzFPOW6tXxYfdq9VWj7P4YcYwglikrA5y6UUKveD0zW0/voPhmDfnNc9tkQ6lz0uzp
	DDhn7PzJPljlhzj4hpZDNyPCcE8iGA4VInXHF/5MuHtJZk/RnAdgnvWNSqc7DRXJtfyHCy/fEe9
	yVCTei7knIyOnNChrHtQd6McdnybdBBN+XGf6DVs2/UOqHgscPSY+h4mPKuYheeO3FoAQcXbR8t
	Y2yGDY0Ga7dg6u275vlMauEm4MNeTB2yi5uyQ0NWD2TMJCFX2tWKrOm4GJkpd8EcX+q3F/NU6Xe
	Y1tTI7XqBiW9w==
X-Received: by 2002:a05:6a21:7484:b0:3c3:8d86:9855 with SMTP id adf61e73a8af0-3da39bd47eamr40391539637.7.1788763536223;
        Sun, 06 Sep 2026 23:45:36 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm17209594c88.8.2026.09.06.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:45:35 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] net: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:15:26 +0530
Message-ID: <20260907064528.6602-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  net: intel: fix typos in comments
  Documentation/networking: fix repeated words in comments

 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.48.1

