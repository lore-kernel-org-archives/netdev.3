Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451883F6C2A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289170; cv=none; b=ac1BUgRyafid1Gnb3S6AEHhVe1Ett9fbScb3O4LS1iIqhyfhumddsp9TBtJ+ThvRWoWURNyeWjrOC6yua52qNYfHegdOGgjjJW+IEhzOQ62Fx3jkn2sIwvdD3SixwJps8v6Jxy3YsvP4pkl1ULc7O5WVnVmQqlq0rQpBaEHjkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289170; c=relaxed/simple;
	bh=HAYPJELrl1gCY6VLg8RJd8Lyd2frEAWknl0CbnmN8qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMOVT+VUHXT2HNs+BGwQHvf4dzA4C285luGTr1E4KM7NIVn5w7fkMIr33nReVk8a0XrMXs5rapzWeBGDgur7pFdv/0p7SYdJg4q+t7Qr3r1xxhQ31rLUlohNBiZ04LF74RgGauzZVVT31yxBWYHwMstVT9IxLlULFDNzxgr2U/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBHQWL9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBHQWL9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C6D1F000FF;
	Thu, 24 Sep 2026 22:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289168;
	bh=jjFxsfu9i9tYynOK4/NPHeq0UmSi72TGc+kGumgbLJw=;
	h=From:To:Cc:Subject:Date;
	b=OBHQWL9LHEG09TovXxpnxcq55v0Auc/zYzySkKj9s1ibT15Gx2JaxBdddHuQxGDUy
	 I+AiXG6I5sOA9xTv3hXZtEEn/9KwBRIlJzGyyTD3tH7MeoM9jzLNVmHMLeTF/2v9K0
	 UhsGbpb5vfUYCOtH0iWz2PoZuhwl4joPP9Zzxuk/qEMHN9at4AIcCfGiR8N/GdAXLd
	 +bOiuj4sec/o9v6UR2AppWNl80mOjmoGSV+Rq4BVVXNCbgtSSXJf/qZfZ+bWwHjlSS
	 gFVK1PKJKd883tPwbmKqrDb6nbyboV0yJBmVfPB2auK4pHdxZsl83QYyznqMGSWQlg
	 1quZXyQkVhdBw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com
Subject: [PATCH net-next] tools: ynl-gen-c: keep the type values of a nest in spec order
Date: Thu, 24 Sep 2026 15:32:45 -0700
Message-ID: <20260924223245.530132-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Family._load_nested_set_nest() collects the type-value names of a
nest-type-value attribute into a set and Struct.set_inherited() renders
them sorted, while TypeNestTypeValue._attr_get() passes them to the
parse helper in the order the spec lists them.  For nlctrl's

  type-value: [policy-id, attr-id]

that makes the generated helper take (attr_id, policy_id) and the caller
pass (policy_id, attr_id).  Both are __u32 so nothing complains, and
every C YNL user of the nlctrl policy dump gets the two swapped.

Two attributes nesting the same attribute set with the type values in
a different order now fail set_inherited() instead of comparing equal.
No spec does that today, but better safe than sorry.

Nesting an attribute set which is also used as a sub-message gets its own
check: it used to be caught by the list-versus-set type mismatch, which
the ordering fix removes, and without it the generator emits a call
to the sub-message parser with the selector argument missing.
Again, no spec does this today.

nlctrl is the only spec affected, discovered by an LLM scan of the spec.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Doesn't affect kernel code, just tooling, so not a fix.

CC: donald.hunter@gmail.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2b3483db1b60..15c79849c609 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -986,7 +986,8 @@ from lib import SpecSubMessage
         self.family = family
         self.space_name = space_name
         self.attr_set = family.attr_sets[space_name]
-        # Use list to catch comparisons with empty sets
+        # Stored by reference, _load_nested_set_nest() fills the list in
+        # after constructing us.
         self._inherited = inherited if inherited is not None else []
         self.inherited = []
         self.fixed_header = None
@@ -1038,9 +1039,11 @@ from lib import SpecSubMessage
         return self.attr_list
 
     def set_inherited(self, new_inherited):
+        if self.submsg:
+            raise Exception("Nesting a sub-message as an attribute set not supported")
         if self._inherited != new_inherited:
-            raise Exception("Inheriting different members not supported")
-        self.inherited = [c_lower(x) for x in sorted(self._inherited)]
+            raise Exception("Inheriting different members, or a different order, not supported")
+        self.inherited = [c_lower(x) for x in self._inherited]
 
     def external_selectors(self):
         sels = []
@@ -1394,7 +1397,7 @@ from lib import SpecSubMessage
                 pns_key_list.append(name)
 
     def _load_nested_set_nest(self, spec):
-        inherit = set()
+        inherit = []
         nested = spec['nested-attributes']
         if nested not in self.root_sets:
             if nested not in self.pure_nested_structs:
@@ -1407,9 +1410,9 @@ from lib import SpecSubMessage
         if 'type-value' in spec:
             if nested in self.root_sets:
                 raise Exception("Inheriting members to a space used as root not supported")
-            inherit.update(set(spec['type-value']))
+            inherit.extend(spec['type-value'])
         elif spec['type'] == 'indexed-array':
-            inherit.add('idx')
+            inherit.append('idx')
         self.pure_nested_structs[nested].set_inherited(inherit)
 
         return nested
-- 
2.55.0

