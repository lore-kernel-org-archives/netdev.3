Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03224293D
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941637; cv=none; b=VevxrInC6V6ftVOgQna1iFtm9sT00E2mTBbIQ2PJ8R+ZlbkiYN1e3QRiKETLhIRLmYxZxTDTb9k/UHIoIJ6/lGqqJEzZJF0CMihFkfCZm/M1l3Hb9qYtHs+Dwsk/7iRKg0KJtWdsD4Uy/pw+ZjyrX3h0aXMRE4YC7ndWGX8w3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941637; c=relaxed/simple;
	bh=66izQXNyU2IQY2Ys3dlmdf04oin403I53sfxnCYySrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap/ZwuzNMUuDYkJm6yxBoKSbpd9zV7eN3Bhoo8UoWqgK2ToY/NbkyZfUF5OCXNzh1gTqlfp/gW6orgBa+cqZdLpwghku+bJJ5P2zram6tqXnFkPIKW1ydNZq9L6aEttFaWk/rgBZYQd1xdln4p/L4Ww/3+4noUtBLsPjMS0YupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMncklhL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMncklhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA33C4CEED;
	Tue, 29 Apr 2025 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941636;
	bh=66izQXNyU2IQY2Ys3dlmdf04oin403I53sfxnCYySrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMncklhLqXiVVfrS+31XAewHFj0BASAkeY0Twaq6NQ/jb/7AVcgfJONmX9fd3LVsT
	 +nhUzGbX3g9WHSPYFlmzMWdB+bs+kqgEcN7RkM/bTYKpBIrIPyEV1vLP2jmOvBQhNO
	 ujiAk8LUFEuq4XCeLsZdQYTcHk6vixKdsqLBjHRmllW+xqE7Tq6IpQjCpSSczLDut3
	 mfLZzRxACcRN8BGYqg5U9lgEGRDxhv7RB1m8EEyDIP+CNJ7Q+AaAIGFycRtwDmBSz+
	 xd3OsZb4GhUmbnN5VJ5qmep+ov/3ydtMM58BeGIQbPz8MDWxgf1i4OwpiHmcJkDtEU
	 jmG237uyi4yLw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 09/12] tools: ynl-gen: array-nest: support put for scalar
Date: Tue, 29 Apr 2025 08:47:01 -0700
Message-ID: <20250429154704.2613851-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C codegen supports ArrayNest AKA indexed-array carrying scalars,
but only for the netlink -> struct parsing. Support rendering
from struct to netlink.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index a969762d557b..a4e65da19696 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -747,6 +747,23 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                      '}']
         return get_lines, None, local_vars
 
+    def attr_put(self, ri, var):
+        ri.cw.p(f'array = ynl_attr_nest_start(nlh, {self.enum_name});')
+        if self.sub_type in scalars:
+            put_type = self.sub_type
+            ri.cw.block_start(line=f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
+            ri.cw.p(f"ynl_attr_put_{put_type}(nlh, i, {var}->{self.c_name}[i]);")
+            ri.cw.block_end()
+        else:
+            raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+        ri.cw.p('ynl_attr_nest_end(nlh, array);')
+
+    def _setter_lines(self, ri, member, presence):
+        # For multi-attr we have a count, not presence, hack up the presence
+        presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
+        return [f"{member} = {self.c_name};",
+                f"{presence} = n_{self.c_name};"]
+
 
 class TypeNestTypeValue(Type):
     def _complex_member_type(self, ri):
@@ -1728,10 +1745,15 @@ _C_KW = {
     local_vars.append('struct nlattr *nest;')
     init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
 
+    has_anest = False
+    has_count = False
     for _, arg in struct.member_list():
-        if arg.presence_type() == 'count':
-            local_vars.append('unsigned int i;')
-            break
+        has_anest |= arg.type == 'indexed-array'
+        has_count |= arg.presence_type() == 'count'
+    if has_anest:
+        local_vars.append('struct nlattr *array;')
+    if has_count:
+        local_vars.append('unsigned int i;')
 
     put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
-- 
2.49.0

