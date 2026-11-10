Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281965;
	b=pgXJmQNYE0G/pcXYvB3lAg6gq1fURlbWsHNu+DOLBhA20YV5SEHnTkVjkDj1p0zFD7gv
	 Ad6BIlLcPJNxZ8sdx/9aZur+iPLK2oadqw9BcjiKnGwO6ZwCQ/HAJLAAHHUrT8eRuczTV
	 sXUOXV1bGSFF1V51XTXIop0HenkXbxDYSjgeaqxatxbtdxOURihqwHaVfKS3AWU16z4Ks
	 codaiDaVIKUhIX+7Es2KovDrB4q8lu+hwlUCKKdld10TMwmNDNxCqEzxcB41r6o9eOOAX
	 OOg8sStevW2Grf3CgQA7/g8SGicfPdNTBpXtTXjtvnfrMadtkBVPGiW0sDOFCSf3atQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281965;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=81yNW9MxXSEiMfVZef54YQxMugIL8gfj9hoUUXY/7q4=;
	b=TakP++swjJSN/gP++qghmfqXGME08sJafWgCDf6nTU5FcVISzQfwFqRDWiDWq+WdlYUb
	 VtZroj1DuDZE5qrilgSrJgv++J0csI1rKD87rkijXavWPwOXcDRHCEEnhPBnlR6mBaZzX
	 gDjoEIKESPiQ1u/D3fIryLdiEICu1p7A9unOhutzxGHecDY5RxSqYuK1X5BjayxfjaiUd
	 BvpbTecoDc+WyyIt9Qse31z6zmTCO/5IhW1I4b8AsUQZBMcEulrQ3zuDyvygjx5i1Vqfh
	 iVEjeZ/lTflXicrU2Fr3x3iD7lmHPjiutjlaxwW0m1JqgSshfQlGIr98gmvQ5PMx+uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=K50xDW5Q;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858DE606A337
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858DE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=K50xDW5Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=K50xDW5QW2c6vcgwdw8sCuvSUfsw1ssz/NnTpl9P/hASM7a0Pf/50yV8xP2oaCoeHXyXmmGIEpDVU
	 PCsgzxanmMR3G4QTtZM6D8X8oBQZwRg/xZQEAgyrfTOofguD9C4o/i3T4mCqZYmCCLu3CfWOZTQ5Ny
	 P5vDH5H854eiMwfU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af291ea022-967b8;
	Tue, 10 Nov 2026 11:39:23 +0800 (CST)
X-RM-TRANSID:2ee36af291ea022-967b8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from home-ubuntu-251 (unknown[180.106.244.228])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af291eaacc-a58d8;
	Tue, 10 Nov 2026 11:39:23 +0800 (CST)
X-RM-TRANSID:2ee16af291eaacc-a58d8
From: Jingjing Xu <xujingjing@cmss.chinamobile.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net] tools: ynl: preserve non-ASCII string attribute bytes
Date: Tue, 10 Nov 2026 03:39:22 +0000
Message-ID: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0
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

Netlink strings are not restricted to ASCII. A valid non-ASCII interface
name makes a getlink dump fail with UnicodeDecodeError, and encoding
such a name for a rename request raises UnicodeEncodeError.

Use UTF-8 with surrogateescape for both directions. This preserves ASCII
behavior, handles UTF-8 names and round-trips raw non-UTF-8 bytes that
Linux also permits in interface names. Do not replace invalid bytes and
lose the original name.

Discovered by Codex-assisted code inspection and reproduced using real
rtnetlink operations in a temporary network namespace. Tested ASCII
names, a UTF-8 name and a name containing byte 0xff in link dumps, plus
UTF-8 and non-UTF-8 rename requests. The original library fails on the
non-ASCII inputs; the fixed library reads and writes the names without
losing bytes. Python byte compilation passes. No kernel instrumentation
or hardware was needed.

Fixes: e4b48ed460d3 ("tools: ynl: add a completely generic client")
Signed-off-by: Jingjing Xu <xujingjing@cmss.chinamobile.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index fb5acb8acded..2402d7c383e7 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -301,7 +301,7 @@ class NlAttr:
         return format_.unpack(self.raw)[0]
 
     def as_strz(self):
-        return self.raw.decode('ascii')[:-1]
+        return self.raw.decode('utf-8', 'surrogateescape')[:-1]
 
     def as_bin(self):
         return self.raw
@@ -852,7 +852,7 @@ class YnlFamily(SpecFamily):
                 return b''
             attr_payload = b''
         elif attr["type"] == 'string':
-            attr_payload = str(value).encode('ascii') + b'\x00'
+            attr_payload = str(value).encode('utf-8', 'surrogateescape') + b'\x00'
         elif attr["type"] == 'binary':
             if value is None:
                 attr_payload = b''
base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.53.0



