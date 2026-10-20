Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494504;
	b=3NW9p/Euyvlw+UIKOf640ImGuLKz4V6xptEnPiWeUvpEQMhmsJtYW9kVACmpuh4QjLQ9
	 Vf7FXv7PYAEFuhu8nd3yjGtYnr5FxKkMQTRrIwOnpvzty6Hd9NlWbCYzJy9U3FNGD2eJ7
	 fnkah48Pb+MfCk3NzuavSBZM6RYgeKXfw9I765b3VcE8Iq4FJGioG2TUNkrkuZZP5rLGd
	 kfivKWdhQlMh3RWqEjiH5iLzWcH1nQbrqCzXZ4AMbUhsGvtmDmBX2JT8iNhq9fjacsJ3T
	 ebv2QqTTmEXWdolTqbm0uX7mBC2p/Oxi1GdNQWK3Id55lJR6xYjDJ6eT5Ol12rJlFxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494504;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=v1hDLLbXD+jIkKcZlH32hhKS/3WgDG8h53ZGgnrgKLU=;
	b=MRN2xGtIsHN8NsASwgOSZTZrUQ+3ZwQrUJQ5eGPYFposo/TSzzmS0EZIhxiFadqeNgZ2
	 dTh6L1ufVlqUTUQI5klErfNrjDQc8skvGM37cqeVDuJyEdeS/62ZHqGPxU+dHS5uSo1WL
	 cDRovJwdXeFDGqqcjpi/e7GWXfP0WrFQDhPJawpaiISZWPI1ulJIrQM80/9eiGxvcnOim
	 qdK6Z+6UGO/C5kmop3DecBWJCghcwtZMMGmsnMuunV+r7uU6xtujt0oZRbTc5wnX07OcW
	 p4MoNe+2Pz/IFAOwZszA82cJcpdFD1pNVzbkU88EAOOvn469n6qJ8pRZCv96Y4PGLyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IXt5pjdG;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9A606A33E;
	Tue, 20 Oct 2026 11:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E9A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IXt5pjdG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=v1
	hDLLbXD+jIkKcZlH32hhKS/3WgDG8h53ZGgnrgKLU=; b=IXt5pjdGcRTALkR/L/
	G+4Un6EfBKQvixkQJgcqyNibb1QBUUY/DJmwdhus3AtQSylF74o3KOX4HwV3rAES
	m/5OHg860Ph43fQn15F2IAD1Vv0qXTStCnLL3T2KEW7rcbzPDE1Q1tknhe2MZ8sk
	QEWV4y8PpVkgt7DxewLDgZMJA=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3H42QS9dq0jWsBA--.49426S2;
	Tue, 20 Oct 2026 19:08:00 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jmaloy@redhat.com
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [BUG] tipc: deleting an unacked group member leaves sender asleep
Date: Tue, 20 Oct 2026 11:08:00 +0000
Message-Id: <20261020110800.960149-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3H42QS9dq0jWsBA--.49426S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW5CFWDAr15Wr1UtFy7Jrb_yoWrGFW5pa
	9Yk34UKw4qvF48Ja93tay8Xa1S93s5J3W3Gw1UJw18X39xJ34qyr4xKr15u3Wfur4fCrWY
	vr1Yg34xCan8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1LvNUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8RGHlWrXS5GeaAAA3j

Hello,

A blocking TIPC group broadcast sender can remain asleep after the last outstanding member ACK is cleared by deleting that member. A new nonblocking send succeeds after the deletion, so group congestion has cleared, but the original blocking send is never woken.

In tipc_group_delete_member(), deleting a member that still owes a broadcast ACK decrements grp->bc_ackers to zero but does not open the group or request a writer wakeup. The ordinary final-ACK path updates the open state and wakes the socket. The PoC demonstrates the missed wakeup with a local receiver and a remote receiver whose GRP_ACK_MSG is dropped; after the remote node powers off, the original sender stays blocked while a fresh probe reaches the local receiver.

HEAD commit:    24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
source version: Linux 7.3.0-rc7
architecture:   x86-64
compiler:       gcc 11.4.0, GNU ld 2.38
QEMU:           6.2.0, two fresh 2-vCPU guests

console output: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/ab80f84de2b7dd0fc96f4cd95cf470951651cbe6/console-output.txt
kernel config: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/8a2ecf2e6af5db6c04703b2db8fb720d73cf586b/kernel-config.txt
reproducer: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/78e655795b3dd1aeffcc8d9d8cc3b482e25b2a97/poc.c
guest init: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/b753c09f565eb4fe17900df2e092f400d69169d9/guest-init.sh
host QEMU runner: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/8d3330b63e982be12b430c17554f7c051060f809/run_qemu_pair.c
QEMU 6.2 shim: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/3881f660adefc2b8f8e2fb93f6168a449d102c20/qemu_sockopt_shim.c
reproduction guide: https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/8b588810ff864a00573269715498cd725ebe6adf/reproduction.md
sender initramfs (base64): https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/initramfs-sender-v16.cpio.gz.b64
receiver initramfs (base64): https://gist.githubusercontent.com/shaos26/370a79297e3334c58f8cb4be22b85a9c/raw/initramfs-receiver-v16.cpio.gz.b64

Build the tested kernel and host helpers using the reproduction guide, then decode the supplied sender/receiver initramfs images. They contain the guest init script and the compiled PoC; the guide verifies both image hashes. The runner expects the kernel at build-tipc2/arch/x86/boot/bzImage. Each guest also needs BusyBox, ifconfig/route/ping and tipc from iproute2, and iptables-legacy with its runtime libraries. The runner starts both QEMU guests on a socketpair-backed virtio network and supports the positive run plus ACK-delivery and peer-stays-alive controls:

    ./run_qemu_pair
    ./run_qemu_pair control
    ./run_qemu_pair stay

The positive QEMU run twice showed the original child still blocked after node loss, a nonblocking send returning 5, delivery to the local receiver, and RESULT=TIPC_DELETE_ACK_MISSED_WAKE_OBSERVED. The ACK-delivery control completed the blocking send; the peer-stays-alive control kept both the old sender and new probe blocked. This demonstrates a missed wakeup for a sender under the stated ACK-loss/member-removal condition, not a kernel-wide denial of service or a privilege escalation. The affected path appears unchanged in upstream master f47d223627f8; runtime validation was on v7.3-rc7.

Thanks,

shaos

