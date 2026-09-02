Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FC45FFB8
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390101; cv=none; b=lq4FUPULD4oRrDGzDjJhqPYTKCpKWMyYWtrSRkeLKQHXZ4mTQxVNza1EUL6MtHdKgJ8vcgw2bP8FhC6cpxZ8o4V3MjNOrtTFNFAcBwpVhAoT9RjfsSb45nwiD8OZlfCeQy0KxUalWP/utyevbB7jVSVl082Z3Ju6NEcS3zxlzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390101; c=relaxed/simple;
	bh=kcIMEAxlbhdfWGQi3kEqTjk3KEi3PkKRsRCd1DxpZ8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWh7mpNBmJIIk1Y9efTlXz0QeyvJW3WR0u5V4CSJBN2mtYIgzUouVu9MUxWF0Pvib63N5U3UTxYqz9GU7UF4yIwcrRWomVJkynVhiEysQWtuHFhd1Rlv5M/TZ+PYYS00j2+vy6U+YKBAo72HsQGlfmozrb+RxCx1tGq7HPPktGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtEMLlZq; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtEMLlZq"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af7283bf83so692895b6e.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390091; x=1788994891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bD7DqrZxcDKFi14tO3Iywp9XBJtjTzYJFW9TgEI/w0=;
        b=jtEMLlZqbh5XoxZ+hKv7J7qrNerk3mPJJlwU0e3x9mRqLH8KV0Zl0oTzAcSGcH6BXy
         XARuMM9w8trkSpV0z0WKyOHwnWbSu8Li9tLpUo82HMxwARMHtLFYCAu3dAZf2Ve+uf3Z
         46cR78RWPllWXa3TYSJY2SFo9eO+IJ09FBGzSYCYjf4nJ/aWPSD8OCnwxV4vUHLStcrl
         l5l4xIWNdwqPtK13gAKo11uqCj324hT3oX0hF/C4wvgVDquZ5U+OuLEsq6CozKso3Y5D
         FIpAGpf9xhDkwPH60evF7VIrbLaR0HDxJAbhup3iYaS2kFdR+uxjvaVXr/0asVKL/ifm
         J3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390091; x=1788994891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bD7DqrZxcDKFi14tO3Iywp9XBJtjTzYJFW9TgEI/w0=;
        b=qcFv8BNLwqj+dCnlpQsxmLXZzDeO6f+HNQ4S3mxiFVb3ORb58WUzLRzHT5bzIZJHaw
         QWRYc5et9uWUqwEtJ9dmr5ozVHt2cEhewh81GoUDZgwenZzQYithxJ2X4GmUNhyg+fRV
         93ZjILX4LwN92g8xvh5mFxVji1ntGBMoQ/zos5fALMKWP7mJbd/4AuORTFnBWtAaACSx
         OrkgfO9/rAHZpsaneSbvqoUhSobKh4NCXk7kDLNyItCBXxsU9A7Fty9gem1C8w0zkqE+
         OCSjqekvE5k+eh+8PyxL19dcZePkOXqlhMWpkIOL3wDwIcCTBSAK9U5HQLKcuaur8GQ2
         +e6Q==
X-Forwarded-Encrypted: i=1; AKwUvByqOpTSKzayGPqbRHgyyivfcA+HlESUNORbfPywEekD9h8EMzKVVDNFxuyLjZlxmG832AgidX4=@vger.kernel.org
X-Gm-Message-State: AFuF++lk82dIcaX3pYtbTsUk9F+1xyMA3YYYQiBt/hLWlxtz0403DjEc
	y9m/J18gSKkD6wm8HqYCC2LMPvNPKT6ZpmM9WkynzTRlf4p4Gc3VqT4I
X-Gm-Gg: AYBFou2egLPQYFj89BRQ4Hf0PsOSwWl3COIfCEyM0Dc/o4nEFvcLBg8E3TKGDGwLuLx
	VdKlclzGjsrdNueL7aJbSTkjlEGu2i0Innn2r3TPwzUPAidQ+KfNzxgibP65TS+2a9pWpIRm42H
	TgA8bc9h1ztPcySrZukVfAxE/Kf+tFPBOAxn9sqjJT3XOS8zC8rOE2QSzjsmdUEC4V45MX1se0e
	lI8Cka0se3rZnkZu9VQeLJ2p38j7iEme68gozqhCnyIwuc7VL7+A6yoYv7+CcMuDl1XkwqGUME6
	Fp24yFAFTmpHeZCpakTwHTnlynglXG09JQMSlWoGajqFgXYRZe2kwyHSEV5pngdKTiYDFaj3xUL
	rF4oAfPr6VanG8O8lcwbHwY54ceJiGmaDlI1Fl1JjPk3ms7T2fKZl4/T17APMFhi88vnKTjG3BQ
	Gbr+vrllc/qVXO17q+AW6iVTJfqi/4Hre2T8ud/nR4aD+m8CWkTDQb33UH
X-Received: by 2002:a05:6808:c1e8:b0:493:a860:5809 with SMTP id 5614622812f47-4b6bc459a08mr7099648b6e.4.1788390090927;
        Wed, 02 Sep 2026 16:01:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:12::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b69b820671sm3086593b6e.15.2026.09.02.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:29 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:52 -0700
Subject: [PATCH net-next 6/6] selftests/vsock: test the assign ioctl
 privilege checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

/dev/vsock IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS has refuses callers without
CAP_NET_ADMIN in the init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/config    |  1 +
 tools/testing/selftests/vsock/vmtest.sh | 59 ++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
index 5f0a4f17dfc9..4b31085558fa 100644
--- a/tools/testing/selftests/vsock/config
+++ b/tools/testing/selftests/vsock/config
@@ -109,3 +109,4 @@ CONFIG_FS_DAX=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_ZONE_DEVICE=y
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 53591fa07f1a..efb94d17d997 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -28,6 +28,7 @@ readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
+readonly EPERM=1
 declare -A PIDFILES
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -80,6 +81,8 @@ readonly TEST_NAMES=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -174,6 +177,12 @@ readonly TEST_DESCS=(
 
 	# ns_guest_assign_g2h_netns_old_conn_send_fails
 	"Check connections made before the assign stop sending once they lose the device."
+
+	# ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	"Check assigning the guest's vsock device to a namespace needs CAP_NET_ADMIN."
+
+	# ns_guest_assign_g2h_netns_unpriv_user_ns_fails
+	"Check an unprivileged user cannot claim the guest's vsock device via a user ns."
 )
 
 readonly USE_SHARED_VM=(
@@ -186,6 +195,8 @@ readonly USE_SHARED_VM=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -333,7 +344,8 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare \
+		setpriv; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1805,6 +1817,51 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
+	local cmd="unshare -n setpriv --bounding-set=-net_admin"
+	local rc
+
+	vm_ssh "init_ns" -- "${cmd}" ./vsock_assign_g2h_netns &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -ne "${EPERM}" ]]; then
+		log_host "expected EPERM (${EPERM}) without CAP_NET_ADMIN, got ${rc}"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
+	local helper=/tmp/vsock_assign_g2h_netns
+	local unpriv_uid=65534
+	local unpriv
+	local rc
+
+	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
+	unpriv="${unpriv} --clear-groups"
+
+	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
+		log_host "unprivileged user namespaces unavailable, skipping"
+		return "${KSFT_SKIP}"
+	fi
+
+	# The home shared with the guest is root-only, so place the helper where
+	# an unprivileged user can execute it.
+	vm_ssh "init_ns" -- \
+		"cp ./vsock_assign_g2h_netns ${helper} && chmod 755 ${helper}"
+
+	vm_ssh "init_ns" -- "${unpriv} unshare -Urn ${helper}" &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -ne "${EPERM}" ]]; then
+		log_host "expected EPERM (${EPERM}) for an unprivileged user, got ${rc}"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.53.0-Meta

