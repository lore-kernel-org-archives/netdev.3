Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332897;
	b=jpVjmK9nNND4rM+M79ZolaaSBoDdBhR05nGmCsolK8YjdGZfWjJd1tkE6tOix7d9wehN
	 I0ttGoqaQVX/LxtodZy3JMNv9l9DGzSvvgbZLGuKymAWyF3tkNlE9kYDhoOEIQ9DnDFG7
	 wbq3TszIoy7tGYunpvyfusjAt+K7HrD6eh2JqfpiNN+X7fFd5Iau3wY4H7urjfiMv7kF5
	 27hzH1AoPCEnAoFddFtZKqkHMtsp8R8fDNE3203K9KEThSoAJIQD1eeaJACztAuvcGeIp
	 Nmfb/upZt/KZ1YZ6lDRBsEDyGbD5ALQX93TcfPW6bvn7P5qFJwuTboU2WXjr1sWKEEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RqQVm9um/aTQzOqldkEmRJM0eYDushIj6WEYdWtOlD8=;
	b=UbhPEUZRv6svVlcQeOEqHjVGf7Ng1mvOXNRPgkKRD0ZUGMBPo7BIGD7RQFLLGoRVJWtR
	 IRsxFEzGVp0hOsd0hjOVe6QVU3+o/AhPpHcJNRmMfEGOMWcgaecLNG4WxVehpl5sQ+LuM
	 3BOKDBC4WAwoKNqEAEDtNW/Pzhi9anBxzw3MNdohBsOiCSqWYH4F6+OzkuJSBje9YNSQW
	 W//3TQqBvbSbnZw206FUxxVpHOMgOo+JqpAXWEa9vXEgw8Vhk9VMYfoWJ+qZLj1zTZAyL
	 0xW8C+Qco8QTGtOBHzHytChsFGIYXF3N5gj6jxT6rB4RJpBFnNx2dn9ygy2fWlScIpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jQwrcRI/";
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D2606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQwrcRI/
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-84621d8c7aaso1030280a34.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332895; x=1794937695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqQVm9um/aTQzOqldkEmRJM0eYDushIj6WEYdWtOlD8=;
        b=jQwrcRI/EDzSHXMr3gQAorj+KqxSQWHaUm8bkHAWGpAA9SqsS3z7kRr5NJqd0EKUkG
         8HpzKSBK2n4Xr29CeavFKqDIDqXa6K9hR0+GevV2OGMFqqPWdVH9rIuvoUn6RdX8iAbK
         tH09q8EUyOl1aScBq6gIdnxKe1FeZB3tOIlt4qLVOxSjVbyrd2KkGTdF8YNbHh+QGh+d
         AqREXWX6g6fXImg5QuZnP6IR/2vK+T9oNmIgyKIPMl86f+OCVl4QHhtjuxUZQssfgx6G
         tethYHJtwQOSK0U8xUQ95e7SfhXgRPBwm51GFwBgE8/ZyHMlrsr90rG0iikO7gHDr//K
         91Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332895; x=1794937695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqQVm9um/aTQzOqldkEmRJM0eYDushIj6WEYdWtOlD8=;
        b=p5jrFrMkgsLxPlojs1axdI2tE2g9A5MdlzTvTjwWm0qjrEjYcOUokM3CUO3l6CGU3z
         OhDToQ4DOt/0D6e2laOKLeGbvEhAxz/lM5pdZCsVSm335YnWDscbqWB3ZBD2sBZOx1YX
         KXdIiYLadxDbSbJP1kxj6IVxmLiWvkyOWCXSTzwx9piza5yhw+brf+4Wa7g0JFCFpTj2
         XJFe0oHiXci8HimYjhbzXVpiTQw0KSB1vrfcE6NoPiMvHKPK1jSxaGJZTZHSJxxgkjpo
         YqKCY30dbSIwcnI2qacZAzRl0++g9CmPHDhMXnv5r5AVcv+VOeSroKxMX2YuGnBquAHb
         8YXg==
X-Gm-Message-State: APuU4Z8Xeewt32Os81cekE7pCzuK+Dmb7FO6+WpdPb4qeDRLu02WZpVz
	pnhfImyuFXavIwkgKOOxNMZd1jxjlCrv1otcf0AMs97zjym15+6KTiskEHQxtvnT
X-Gm-Gg: AYBFou2f+XTAmakwPc9iaTwgQcyw2ilSTmpm1IMYA+qULRb5VDGmi+NOrQby4gmvVe/
	gFNZFVVnNZb2OCpW2AGQ9aAMcaFkHk4xuQcNVpST6QnzszL3F++QQPhAJ6EoHNJQ+xJDXDVAs9d
	FwF5TlZtZr+Bw50JDpSMwlugMz2aP+16TUY1/NrP7Ug3KsnPG+PuqYl1KuF6AAE8owAHnMFiBrP
	aXP6RrfXvTDXOgy7vR5JrDHSLZekhX0plYfkLKw5pkZqpiZtnGdyuOR21I1SXdg54sLu1Zsl+IV
	3W+JxRkmCPrLA3gqjjX38squ/LHqDSV+ulGcuf6PSaJ/67mSaRAIv3VMKlGFGMvvDDcM/JKPDAW
	ffTV2BCM6GdC0jkU63wLHCDQhaPYnI1S8clk8/HPwJXokXEfBjhTpPIHPmVqio1feqOjG9V1Pba
	GUeEX2syBGje8ukWPZYyj2oqJWt54GuqjGhUmeLd5vXhKmmAvMUkCtkyHfYD9t014ALsccSzeRi
	pxsq515ojTBiobYJ2SHLsJNW/TW59o92HDA1s5y7rWBwwlDHLZrouqQVuOkKSKyrDPxWBE/TVAg
	8PmFcy0CUJU595nCsyIfSxlb
X-Received: by 2002:a05:6830:915:b0:7fa:ac4f:79a with SMTP id 46e09a7af769-860dc82c5ebmr3664031a34.22.1794332895384;
        Tue, 10 Nov 2026 09:48:15 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dca42411sm2389254a34.1.2026.11.10.09.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:48:15 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v7 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Tue, 10 Nov 2026 12:47:51 -0500
Message-ID: <20261110174751.973464-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110174751.973464-1-houminxi@gmail.com>
References: <20261110174751.973464-1-houminxi@gmail.com>
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

Both families register a SET command that the spec never described, so a
YNL client could not change an existing datapath or vport. The datapath
NEW command also gains the masks cache size, the per-cpu upcall pids and
the ifindex, which its handler reads. new, del and set take
CAP_NET_ADMIN, which is GENL_UNS_ADMIN_PERM in the kernel.

The datapath SET command changes the user features, the masks cache size
and the per-cpu upcall pids. A request that leaves out user-features is
read as zero, which clears the features set earlier. per-cpu-pids takes
effect only when the same request sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU
in user-features; without that bit the pids are dropped and the request
still succeeds. The masks cache size has an upper bound of 4096, which
the attribute records.

The vport SET command changes the upcall pid. It finds the vport by name,
or by port number when the request carries no name. An ifindex or options
are rejected with -EOPNOTSUPP, and a type that differs from the vport's
type with -EINVAL. The type only has to match. The vport NEW request list
gains the port number, which its handler reads.

The ifindex attribute is signed in both policies, which read it with
nla_get_s32_default() and reject anything below zero, so declare it as
s32 to match them rather than leaving it u32. The field in the generated
reply struct becomes __s32 with it. The reply itself does not change:
ovs_vport_cmd_fill_info() still puts the value as u32, and the two types
have the same width.

The ops in both families skip strict and dump validation in the kernel,
so the spec says so for get, new, del and set.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 36 +++++++++++++++++--
 Documentation/netlink/specs/ovs_vport.yaml    | 29 ++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index f7b3671991e6..b24dc1e03f46 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -102,13 +102,17 @@ attribute-sets:
       -
         name: masks-cache-size
         type: u32
+        checks:
+          max: 4096
       -
         name: per-cpu-pids
         type: binary
         sub-type: u32
       -
         name: ifindex
-        type: u32
+        type: s32
+        checks:
+          min: 0
 
 operations:
   fixed-header: ovs-header
@@ -119,6 +123,7 @@ operations:
       doc: Get / dump OVS data path configuration and state
       value: 3
       attribute-set: datapath
+      dont-validate: [strict, dump]
       do: &dp-get-op
         request:
           attributes:
@@ -135,24 +140,51 @@ operations:
       dump: *dp-get-op
     -
       name: new
-      doc: Create new OVS data path
+      doc: |
+        Create new OVS data path. per-cpu-pids takes effect only when the
+        same request sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in user-features.
       value: 1
       attribute-set: datapath
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
             - upcall-pid
             - user-features
+            - masks-cache-size
+            - per-cpu-pids
+            - ifindex
     -
       name: del
       doc: Delete existing OVS data path
       value: 2
       attribute-set: datapath
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+    -
+      name: set
+      doc: |
+        Modify an existing OVS data path. The kernel treats a missing
+        user-features attribute as zero and clears the previously set
+        features. per-cpu-pids takes effect only when the same request
+        sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in user-features.
+      value: 4
+      attribute-set: datapath
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
+            - user-features
+            - masks-cache-size
+            - per-cpu-pids
 
 mcast-groups:
   list:
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index fa975f8821b6..5a3ac4b03033 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -111,7 +111,9 @@ attribute-sets:
         type: unused
       -
         name: ifindex
-        type: u32
+        type: s32
+        checks:
+          min: 0
       -
         name: netnsid
         type: u32
@@ -128,18 +130,23 @@ operations:
       name: new
       doc: Create a new OVS vport
       attribute-set: vport
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
             - name
             - type
             - upcall-pid
+            - port-no
             - ifindex
             - options
     -
       name: del
       doc: Delete existing OVS vport from a data path
       attribute-set: vport
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -150,6 +157,7 @@ operations:
       name: get
       doc: Get / dump OVS vport configuration and state
       attribute-set: vport
+      dont-validate: [strict, dump]
       do: &vport-get-op
         request:
           attributes:
@@ -165,6 +173,25 @@ operations:
             - netnsid
             - upcall-stats
       dump: *vport-get-op
+    -
+      name: set
+      doc: |
+        Modify an existing OVS vport. The vport is picked by name, or by
+        port number when the request carries no name. An ifindex or options
+        are rejected with -EOPNOTSUPP, and a type that differs from the
+        vport's type with -EINVAL. The type only has to match; the one
+        attribute that changes state is upcall-pid.
+      value: 4
+      attribute-set: vport
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - name
+            - type
+            - upcall-pid
+            - port-no
 
 mcast-groups:
   list:
-- 
2.56.0

