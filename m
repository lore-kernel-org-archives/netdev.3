Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CF376481
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039922; cv=none; b=ZAtW3xIGjEN7TicZxs+K0/XW1RqrUi0Ho8JVxQZX12D7vYlsdQsldYKxAiJrOnQOeNtFrLpCHYji3pKq+pWqBFxHMz+MjkSUWiB6y16C8H8xi7Pi+zxAEMH0P+DPuNq6Q+vTiGq5hiEJ6HANU+4N9atRjAHsoOmAnBwENb16DS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039922; c=relaxed/simple;
	bh=iVYKuJ2DcdFXVTgCRt4VjQYmkYPGzA6mYOOB5aRIk7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJvDGtuqwZ5CdmXduz3QiRGm530sGejA8oiB/u1TDzdS2f6liMQ1ozviMszWbbT0XsZ0FpNpTJXhGvnpuLEcg1XmuOmQUwwmsTdcEkek9KZiVwUIki+jd7kCqLWl3XYygj0IBT8By7K0C60WoTb+HxBW1kbeRV0mr8ZaWTEwiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqGY5VQH; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqGY5VQH"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4c0cd10d56fso303796b6e.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039919; x=1790644719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45Bl+e2P9YwHGQJKKsleiX3YXi1lYrJXOyTW+Ow8cCQ=;
        b=nqGY5VQHingWkjqz8rdHQazhI1p2mM16VrhuO0xQaz81oHN/TP+OoUNzyB/aLuuU//
         tzCy0dKHbaLLREIw/fXGxnQER0k3SarDCQZz38biP9bBFjaHjQj8/+Bzg2yZphjROzFE
         H2iEb/9Jw5DgRFfUG615DEPB8HZ9DuAhnvpLAikgc1MIMdaRf8th3j6xpqeKrOeoJcXH
         /vG60R/D2g+IYlvfg6tvkjZ+pF1CNfW+qpIWdN+xzFlC8b2bgKhZ2115hcaCCCmN6AqJ
         Bf21rkaspTs7tN3qJY4C8EdecMERH3uMBJFTwKWSYjiTDsOlIe5+HiNJL8w2aJP7Zdr2
         RA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039919; x=1790644719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45Bl+e2P9YwHGQJKKsleiX3YXi1lYrJXOyTW+Ow8cCQ=;
        b=ZWcd0U+Tt4G5Rfbkm13VpQBLj57ndT/dHzrCh3XdUUoa5LXrWNOub91bBalPydg5WU
         w4IgRvCdLOwyn3gd5x8KyA7STiURYlM6yUfnN/hILb4NVrtr2J+RidKCBDE3w5ALNTvv
         DKWh2way8twATUGbTugVyTDJthFpYeYZjz5nh4tKKeEeno7EYCEHpRgrH7JkPJekbAPw
         v6clbOaytAVnFuzAqtNMLn2wSsKUkwmoi7nRQA+NC0xuPXE4eOymPLpbmpDevYvy6V9S
         cgQhbPSb+Q4xsML1kdPy3iInVxxOPud/G2YZLSk29Zoztj+ARDhJGSjvY0ulmfLUKlT3
         /FMQ==
X-Forwarded-Encrypted: i=1; AKwUvByzyBKpHtOuhrM1EnUth1HGKM79pYh/jAy81HCNOE08Y72sK4sogBo27HycLWqTzkavY8B7XjA=@vger.kernel.org
X-Gm-Message-State: AFuF++kdqIhek27V/hCsx5GrlfNLt0Um/C18MMd4JiI/DV6se/GusRCZ
	k4yBgM9loFtj2HaKrEjD9OyApxdGdK4BbkmxihHMRanSfjFYQ1AsREMK
X-Gm-Gg: AYBFou3F72Pl5wLfDAI0dqsZ2XTBqdlCzjV6/VEuQLLoLg8+uPUBDbxS5IY6dGJP7D2
	oMdYlENYf6KpoRzXummbV9NYLDQz+KHTN+Sfbf/vcqqbgtw3P8g8HrN//Eaj2jrigYGWzj3Cp/M
	+rfkRsrgqL2MSgvbPQO2OBpUb/QTJDLpEREPhB2qzUoI6gygMFzjNHUVfLHOsyZvhD3EzoD8fxj
	x4AXQTvqMBjV3oH0NDD5OZc8zkoWhj/2Q3Wz+eK/Z3DK0vC6GvNsrX+Si0YPK8fgRlqnW1DLaf2
	zyMUOfJpRzIp0IIt9Fg/1bb8/UswKUtNmJx7f5cWkBra9Vh/nedYWg2z5rTjQqLN2bC8J15Vpzx
	X2wMQV6NgxJeZFBzJ8nFa9V9pUy3dSd/1jxXEo9zfaV2JRuEGyjI4vyFa+k+KUGaCpPCrPzzUrP
	AgZ8XldT+jVRXL7TWv58NYT5UJpwkDRn82xZ7r6KEXBmgkehOKIykJ0xyOplcaV5dWF8c=
X-Received: by 2002:a05:6808:1818:b0:4b8:4703:db88 with SMTP id 5614622812f47-4d4388a7358mr1277287b6e.17.1790039918606;
        Mon, 21 Sep 2026 18:18:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d4bb6be7b3sm129951b6e.0.2026.09.21.18.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:37 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:09 -0700
Subject: [PATCH net-next v2 6/6] selftests/vsock: test the netns assign
 privilege checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
init user namespace.

Add two tests: one confirms that CAP_NET_ADMIN is required even by a
privileged user and the other confirms that CAP_NET_ADMIN in an
unprivileged user ns alone is insufficient.

CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
ns case.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Assert only that the command fails, not EPERM: ynl's cli.py does not
  report the errno (Sashiko)
- Use ynl cli.py for the assign
---
 tools/testing/selftests/vsock/config    |  1 +
 tools/testing/selftests/vsock/vmtest.sh | 54 ++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

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
index e94cc2fd90cc..4f42bcdac3f6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -81,6 +81,8 @@ readonly TEST_NAMES=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -175,6 +177,12 @@ readonly TEST_DESCS=(
 
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
@@ -187,6 +195,8 @@ readonly USE_SHARED_VM=(
 	ns_guest_assign_g2h_netns_host_connect_ok
 	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
 	ns_guest_assign_g2h_netns_old_conn_send_fails
+	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
+	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
 )
 readonly NS_MODES=("local" "global")
 
@@ -335,7 +345,7 @@ check_args() {
 
 check_deps() {
 	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter unshare \
-		python3; do
+		setpriv python3; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1832,6 +1842,48 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
+	local cmd="unshare -n setpriv --bounding-set=-net_admin"
+	local rc
+
+	vm_ssh "init_ns" -- "${cmd}" python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -eq 0 ]]; then
+		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
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
+	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
+		python3 /root/ynl/cli.py --no-schema \
+		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
+	rc=$?
+
+	if [[ "${rc}" -eq 0 ]]; then
+		log_host "assign unexpectedly succeeded for unprivileged user"
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

