Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6E4F402D
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569784; cv=none; b=sYtAykNS10X70427k9+sW6aKQpi1I/NbUG6IEglqYOcS0PPtBqsh8QA4EFSU34uMu9u6q8P+ECw+BUzy8nnOohr3QBqWQXJwvoyEexWz8S5sPKvBcda0LQxnjWJ7ECW/fe++jEAgZyyWdQJV+kzp2W93TQyOZbqU3yXH/qWwQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569784; c=relaxed/simple;
	bh=mvTDjrt5Dv25R3e84Btc+sW0GIDNqjbWHM1WFt4kyIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PTpdch9qWMKiQyNZLXT4gcptuW6e1usTgfIDNZUv8QkHGh+6yny6/3QTUEGvK4aY8l5L6ZOD4ySsw8de66m9rOrO6EeLl07AbY3EvPtAloqjfur5fFOqapmvu4tZNpWWF4Jl/rR4rItTmju5eO5OKWc93ZAvi+eliNjdLiyBIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHfmligZ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHfmligZ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so68900435ad.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791569782; x=1792174582; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
        b=uHfmligZJUMf9NEIjK8+rexxzGECBkA4KuJITj7YpfsIwnrvRnEe/Pj5MF2fVeaDNg
         p3DDiSX/XfsCi6yK9ynvix0jzTKlRMWE5WwB9B1pHPssiqMLyODkl0LlFvokaC9Kisxg
         8bm2cPs3+CAeKd5BEJWC8jZ9I6HpH1Q0YQLz6wtCubcZe/f74jipZ79nx198AH3UFlZt
         R+0OPyOZBBlvGhZP0F9zbm86/kPCptYCUo/rz/CUonPA5Qj7/bv+HNVtdvU5yDiZ19+w
         57ASKnoFW46pfux9MBbJ7NRpl4flWEK4tWN6RqWNionBoMXTnvm6tA2ys02z1cwbVD5t
         jXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569782; x=1792174582;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/kiALaK1i6cuDxf/sysDWLUxJOWIbgnuKC2Zu4gvHcM=;
        b=inEEQSgU7DA7Z7Afmae5/YWDu+Z408kIAjs2x0FP+UinW+WkJKJi3Gmgd/Jb/DJXZ1
         OSxyOKfQptuMmT839QaYbaLHrmYv2dHmKjKNudINsrlYlI8e/PlxdqrnLfTlWExUkImA
         pAWAZkosZdPBckepDVPchavZRypiOfSp+Oyp2BAojc2lWztPQom7WuLooAu6PUu/oSGL
         2HXszyHI2wiOrMXm1wCZyM1wfP1EkkvN7mG0lM4Sg4w7WIeq7vY9eZzrJNH8HJMQ2WVh
         DsEQtlBVMqhtSKkX31mUC+GOW4QSYs+Ar6Song+PiRZFVQV+P/HqJNOD1lfyS5MtZc5u
         UB9g==
X-Forwarded-Encrypted: i=1; AKwUvByhqTq2VAa776ph963vvxY+Fuhg69qYqObBx5KPa1EyzWNSLKqbIOb9Ed3GB58FC2uYzh4c2DU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZHKAHMo59mGJxtY+31PEH7/NmPuGn4qoKxbhIxFkZIEJXbeRv
	vSIp72Mcc9byqrogEghpemvOC5SzbcBVLT6k7vaQG8CMdwiY1kQ23FVGSEVlxHSL+qchhfc4m0k
	1IxPlEGPLgw==
X-Received: from plcf10.prod.google.com ([2002:a17:903:104a:b0:2e5:6b23:1f55])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0d:b0:2e5:6af9:a745
 with SMTP id d9443c01a7336-2e842ac678amr21256985ad.23.1791569782074; Fri, 09
 Oct 2026 11:16:22 -0700 (PDT)
Date: Fri,  9 Oct 2026 18:15:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009181553.582029-1-brianvv@google.com>
Subject: [PATCH iwl-net v2] idpf: wait for the reset completed state in idpf_check_reset_complete()
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Emil Tantilov <emil.s.tantilov@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"

PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
function reset progress as a 2-bit state, not a flag. From the IDPF
specification [1], "PF Reset Status - PFGEN_RSTAT":

  00b - reset in progress
  01b - reset completed, written by the control plane
  10b - function active, written by the control plane once the function
        has completed VIRTCHNL2_OP_VERSION
  11b - reserved

The "Function Level Reset" chapter of the same document has the driver
poll the register until it reads 01b before re-initializing.

idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
although only 01b carries that meaning.

That only works if hardware moves the field to 00b as soon as the reset
is triggered. On the Intel IPU E2100 (8086:1452) it does not: PFSWR
transitions PFR_STATE to 00b only when the field currently reads 01b.
When the function is active (10b) the field keeps its value until the
control plane finishes the reset and writes 01b, which takes a few
hundred milliseconds.

Consequently, on a hard reset of an active function
(IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
reset is still being processed. The control plane tears the mailbox
down underneath it, VERSION is never answered, and the driver sits in a
60 second virtchnl timeout (-ETIME) before going through a second hard
reset which then succeeds.

An FLR on an active PF is enough to reproduce it:

  # echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

  [  299.685030] idpf 0000:01:00.0: HW reset detected
  [  299.715710] idpf 0000:01:00.0: Device HW Reset initiated
  [  362.916087] idpf 0000:01:00.0: Device HW Reset initiated
  [  364.318246] eth0: (slave eth1): link status definitely up, ...

Nothing is logged during the 63 seconds; the timeout is silent on this
path.

Make idpf_check_reset_complete() wait for the state to be exactly 01b.
This is the stricter reading of the register definition and it does not
depend on how the field got to its current value: functions that are
still in progress (00b) or active (10b) keep polling until the control
plane reports completion.

With the change the same FLR results in a single reset and the link is
back after 1.5 seconds:

  [  206.856635] idpf 0000:01:00.0: HW reset detected
  [  206.887106] idpf 0000:01:00.0: Device HW Reset initiated
  [  208.368721] eth0: (slave eth1): link status definitely up, ...

[1]
https://github.com/oasis-tcs/idpf-specification/blob/main/idpf_specification.md

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Li Li <boolli@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
v2: reference the IDPF spec, name the device and add an FLR reproducer
    with before/after (Paul); collect Reviewed-by tags. No code change.

 drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..ce8a1bd0ec8b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -166,6 +166,8 @@ struct idpf_netdev_priv {
 	spinlock_t stats_lock;
 };
 
+#define IDPF_RSTAT_COMPLETE		0x01
+
 /**
  * struct idpf_reset_reg - Reset register offsets/masks
  * @rstat: Reset status register
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..92eb3e9de77c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1874,7 +1874,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
 		 * register for us yet and 0xFFFFFFFF is not a valid value for
 		 * the register, so treat that as invalid.
 		 */
-		if (reg_val != 0xFFFFFFFF && (reg_val & reset_reg->rstat_m))
+		if (reg_val != 0xFFFFFFFF &&
+		    (reg_val & reset_reg->rstat_m) == IDPF_RSTAT_COMPLETE)
 			return 0;
 
 		usleep_range(5000, 10000);
-- 
2.56.0.385.gd3acb90ef8-goog

