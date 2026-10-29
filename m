Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793257943;
	b=soRoMu0m6DbBAaeeKYFoOzEzYXsfSLWtHOabIcmiQqODfuRd1D9StjnrDXbzyhyYyIOJ
	 G3zb68wlfzl/UifjcM87DqgDr10TYrNMW37khb04jobo7ysh5157e3TqWU9NsYw5/Ov6Y
	 /KvuNDb7asiEF9S04lnT3N6+gvOVTt5/szg9HfeOdfPdXVXhHvzF9PVdd6aN8J+QdLYrO
	 gQo0WMZhMpX2WmgqUouA6XYSWXoCt1jTK7V8rLLjX7uB2L6D7XqhkyPLuZ8mQoBvrEgUu
	 KCuGwIvml3rDMfC+cVYYXXz/AmEtq9Ur5kbJQIxH3tbsFvWBpI5z8Rpnp58o6wIkbBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
	b=WArFk5tdOvg4L1gb3dpeAmIrjPfa7qRzvIBZAkRlBsOrjHYG4be7oyWxb4oWsbRRR6NP
	 CurBt0VE3LTWbV2QEx2KlwzTxYcxrZxTFRUeR+K9/LnNchDnbFI7GQsA5O/1tcRJZUqEo
	 OJ36QPAHxA9svKU/MCgyCrNuvv/McN65JqzkE9c51RAilsGZe9+rKiWGyP91L0RREs2Il
	 xB8LyGnsdf2vYkKmW2hJWPnPgp/8o1Xol5+ETRux3q+lPtfXtzQsWnz15TSwZKTBZjnjH
	 GrOuVMI5zIXwo8Kxi/77w+O1b54A9th4zDY0F7iw/oWcZWGDS1gvg91U32EJWdMIT8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w+dn/dwg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15938606A32A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15938606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+dn/dwg
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so17232055e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793257941; cv=none;
        d=google.com; s=arc-20260327;
        b=Ss/jBAhx+7iFpiYmkG+DRYkvC0YohdM76U5n+dsNOTHofAroSHJ508/XmHDXNOEU6B
         xUvmuIvFovvxUAMC2/DKLxKZ21bTS4QiGMofszd1tXwF5+ow+vX16YLONz3vBLxE6Oli
         LtF3P/MbMrsMAre/oslO2u/SbYBtBOcaXIdQPGHRxNepZhJZVBCPb1pYmNhYgYGPLWIF
         dfQsUDRQrVdNdZLAGl5CrdF6xg6Lwt5vCPeEflFyyk8j+0Qd/k39Tmtgstj+9Fx3d/FA
         0wLzq4HMwg2knmI1t+MzmFvV9NuhdrLZfRLFCkokZ9eHuLOYfrENiUGSGMlx25W0XuUK
         uu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
        fh=J9zhibSnvYPl4aPKVDvB7Td+dNQMmSA4KwQI97Hcoo8=;
        b=isSlDxHzCwidJzPgFLfyD5HUKK2KXLnVG3jOvdeAEziZgAuGfZyZqAdQc8G09pNdfV
         +R1R2HgDVTGAWCJoCWO/CanMud6jZaqvPLICDwYHdu+hv8yLMsuGm1k5+LND1hpP8PXn
         fl6Sgu7hIkhFCLHsZBJLmX1sXfdoV7ekAogM/bVk7F2hnSIBxTJZ4bQ+GmkGCoAocg0+
         M4nflEcyI/+jPGvFPtWMKvosgUWT45+IEPhK4YfrCD8w++q8y6uJ+WjT3Vw2YUFJQMOc
         u5YZIYF4wuI83xG53E/qHy0uAFHYIqQX/CcH9jBZUNaB9KQghpFgfKPXxXHmrYaJOVPy
         FJxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257941; x=1793862741; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
        b=w+dn/dwgtbrysHaAXv9ETJPfMsaFELE4gakBZpylLTZ5oGcJrz5KSTONKHRlOdE2I4
         IWwoXJjpxNpfxrVO2kDMbcup7bpMDblzyW+qq7XJI/IJFjCe4wqkAHp8PB9Cy7oyNhOF
         unwwH+zFYGfXrW7pOQHwxSYLXWpKmpbcLrGKBqh8OKO+bLeAU3dxFPBtGnFChn/8keYi
         XVVkXjIP6SzJ3dv01NteeWbX91ClybUiHZT7/g/Ua9i9YO1VAI1S8Xd8/InCgNtdg0yv
         rdsozN/MTriCUneq8he1ytUB8+ohVVoULeuVXz8xwsAMHAHhQXQo1AsAI4pQCorBJX27
         KESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257941; x=1793862741;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OKTunFxy+QwpzleRwVzIIagIb2M+Uzm8Zh8ZKBDtS0U=;
        b=f2Kuwd0MXs22tCRmD2NLWvlS1cgZOQPj11oxkN8csQZA7wIECONUPpJRpLbHYLIgik
         /00URfevnDoYAMnqNtGV1cY1nyskZAR5ZZ9OqePeq5Ceb4B54Xpt4hOlGpF8H1yVyU3l
         Gb7gA7hte9izWCxM/yurQfYfk2c5JUim/g6OzKi4DSaG/AF4TeqSshx+KxF57wQAbpxM
         Hb9a57lizFmTHxwBaojsF+fhxG9fVlmvBGNr9JPPngSmTi8/FuqRMkd/QTW/9HOf2wz8
         v92nODgUmP78KNyIVkxGpQicOrYgR1CgSHbJhLsX7PH6fcKPfvoh27POrPkPM4+4T0M0
         9ETA==
X-Forwarded-Encrypted: i=1; AKwUvBy2TeXxei+EqUt/FY8EXUShEHS3DVyBNRGoE6O61HSVd4A6UF3P4B6JbecukfVHRHv9nQaMXZk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJWGOFPm5eU+zKLS66mbpnay56UXioxuOGk55jzw1iOu38GU+L
	4jPOpJA7jgRuRNG7sHGOWZDi0TsLSrX+/+55DLOJlMyZZ0U3GoKcK5hOKDryUEZrAfmi8hyLmb1
	GfdzR59Q1O/TJnt6+ZYGEIJydYPD3FaU=
X-Gm-Gg: AYBFou2k46cEbSns+GSRdK3ZMa/swriICgQRGL305LhSkHWu8HLTqIqMUFOHssnnDF6
	ejtHlTyZd+MSFKlQs0XdOHqmpU2sqBQz4qouLhD7qNFXuZS7Z09p+YE23SdvJ/nVDwYzAsuosqL
	e4rAVMiE4M13HpGq0B3no2GLj3wBrVyCAa1ghENAiNtrHbTh8fXtU//rqW6mMOi4CjDeyEAG3KD
	FwAwkSsDU9wQw6VfBfSf3V2fJW4Ye4r5Q1X05hEXdh+6T420ZpGG6cqC7xDp9E6mw/iYtfTizGZ
	KHc3b7phHd9pKnKCEvLDNgSi3UK9fteBZtqTZs8I3cqM2E2ntwicXMqsTVO4OBvZzhW5L+jWXsC
	6VdVA35JmV2Vmf/7tSWzIPKzX4eEKrEcsbHZyNdkxCNf4KWEAJFj4jZHo8dv6apSAwhVPrByW1H
	ENlIOEBKPnCnkH860jFw==
X-Received: by 2002:a05:600c:1f94:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a9663995a8mr105499305e9.12.1793257941322; Thu, 29 Oct 2026
 00:12:21 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ahmad AG <ahmadag1001@gmail.com>
Date: Thu, 29 Oct 2026 10:12:08 +0300
X-Gm-Features: AclHuK8oIQAbFPj51xALKq0pQMpaX8tYjUogaYqwbvGOzn7JupmqQ2AXYVRoUe8
Message-ID: <CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com>
Subject: [PATCH net] net/packet: charge fanout groups to the memory cgroup
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fanout_add() allocates a new group with room for max_num_members
socket pointers. Since commit 9c661b0b8544 ("net/packet: make
packet_fanout.arr size configurable up to 64K") that is up to 64K
pointers, 512 KB per group, from a single PACKET_FANOUT setsockopt().
The allocation uses GFP_KERNEL, so it is not charged to the caller's
memory cgroup.

Each packet socket can create its own group, so a process with
CAP_NET_RAW in its own user and network namespace holds about 512 KB
of kernel memory per open socket that its memory cgroup never sees.
In a cgroup with memory.max set to 16M, 256 sockets each creating a
group with max_num_members = 65536 took 264 MB of system memory while
memory.current grew by 380 KB.

Allocate the group with GFP_KERNEL_ACCOUNT, as other allocations a
user can make on demand in the networking stack already do. With the
change the same test in the 16M cgroup is stopped by the cgroup's OOM
killer, and with memory.max at 512M the 256 groups charge 262656 KB
for 264640 KB of system memory used.

The missing charge was found by code inspection of net/packet/ with
the help of an LLM and then triggered with a small test program that
creates the sockets and groups and reads memory.current; the numbers
above are from that run. Tested in a QEMU/KVM guest on this tree
(x86_64_defconfig plus kvm_guest.config, KASAN, MEMCG, PACKET),
running the test as uid 1000 in a cgroup v2 memory cgroup.
tools/testing/selftests/net/psock_fanout passes before and after.

Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size
configurable up to 64K")
Cc: stable@vger.kernel.org
Assisted-by: Claude Code
Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
---
 net/packet/af_packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c91..406397acc5c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1778,7 +1778,8 @@ static int fanout_add(struct sock *sk, struct
fanout_args *args)
  /* legacy PACKET_FANOUT_MAX */
  args->max_num_members = 256;
  err = -ENOMEM;
- match = kvzalloc_flex(*match, arr, args->max_num_members);
+ match = kvzalloc_flex(*match, arr, args->max_num_members,
+      GFP_KERNEL_ACCOUNT);
  if (!match)
  goto out;
  write_pnet(&match->net, sock_net(sk));

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0
