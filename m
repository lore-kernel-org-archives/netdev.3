Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216959;
	b=WNrJkUkZDRf76vAPEXV/Nw08i4zjajZJZBzgi0X+t4lEI5BnA1fOYWbHkyRdIS5vFHOp
	 LnGFsqtxFUDW7R4C7kgYZcghTQan3gRJaKgV65RALxWP4DQll2M8EliorIhFUQd5qtouN
	 I8ACAzLXnDrYG72Cnhs4OpFETS7X3AKoCIlc4VozR9QK08Zyb5nV+iY2j/JYHCuNZMJpE
	 8RWdgiHrjNV3TDKRZUBS+w3xozz18STlYfCFosudOYWRYaL/03ASpqpVAT9suIpsXPcRM
	 iJU7e9zYy6lgXd2LoKfcyjOcvXVzid/LF+AJwhNz/BYniA49G9QLa4gg0i0Jk9moE5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216959;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=Vxez0Rgpzes99K6x2T7B3nIvRzO9kUQMcRduTsuPTss=;
	b=ZArm50QnXzcC4uOOlHUF5f0v5K0rL4vJnGkZ1vlqxIr3M2mkmx3/JG7xfyqoLbJBYQSw
	 Z3CVXLKWk3zQa1e+X1CjgVwZahy/TAYbPSE5QlsFjgYBrPp7279qta4CTFfg5UCUPA4Wv
	 hp3OR8bsyrh4TGa3uJd3IYF9Rxuhz7l0dK+396ZphYqtggYpjvYPTv94Efq7FXQT7uQko
	 PORWaVr2NiETR+qGgsRakQBMUrLRrYX3x/x0T8IGhbdzsLv9fGxpQgINFhVWErZxSWXYU
	 fHPrIrkkoPTpK6+bWt1t64V4lTWSdPhTVcxzdG84L5+uUSF68YR6fmWYGJAweTeCcYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FClsJF7J;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5E606A331
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF5E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FClsJF7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794216958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vxez0Rgpzes99K6x2T7B3nIvRzO9kUQMcRduTsuPTss=;
	b=FClsJF7JtqTHggxvcNt7WaNT3ABvH1UZmt49dtTGBEmv0kYuO0PLLBMq1M/O08MShKmV/4
	ppBe69mK++S7JOXZ05PKsmwFHCMAkAhE5iSLU5Z1jce0BYh/btzJcAWyrZkM0NBJpwbRBi
	m4MKzxNZnCuhUc1Q/EeBBpTjfGJDjiY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-OTPyD9LIPOKpETnXOeSJNw-1; Mon,
 09 Nov 2026 04:35:52 -0500
X-MC-Unique: OTPyD9LIPOKpETnXOeSJNw-1
X-Mimecast-MFC-AGG-ID: OTPyD9LIPOKpETnXOeSJNw_1794216949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F44F1955E85;
	Mon,  9 Nov 2026 09:35:49 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B850818004F7;
	Mon,  9 Nov 2026 09:35:43 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 00/14] dpll: add a simulated DPLL device driver
Date: Mon,  9 Nov 2026 10:35:09 +0100
Message-ID: <20261109093523.931201-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The DPLL subsystem has no in-tree driver that can run without real
hardware, so core changes and userspace tooling are hard to exercise in
CI, and the pin-on-pin and reference sync paths see almost no coverage
outside the vendors' labs. This series adds dpllsim, a simulated DPLL
device driver, together with selftests that run against it.

The driver is controlled through configfs, following gpio-sim. Writing a
clock ID into a device directory and setting "live" to 1 registers a
DPLL device with the core. Pins are directories under pins/ with their
type, frequency, direction and priority as attributes, and all of them
are registered when the device goes live. The split between creating
the configuration and going live keeps the register and unregister
paths reachable from userspace, so they can be exercised repeatedly
without reloading the module. Nothing in the simulator is a stable ABI.

The patches follow the shape of the zl3073x introduction. The
driver starts with the device alone, then gains pins and the static pin
operations one at a time (state, priority, frequency, phase adjustment),
and every feature patch is followed by the selftest that covers it. The
last two patches add concurrency stress tests and reference tracker
leak tests for the lifecycle paths.

The simulation loop (lock state machine, phase and frequency
measurements, monitoring features), the topology features (MUX pin
hierarchies, reference sync, media failure injection), netdevsim
integration and device mode setting follow in two further series once
this one is in, to stay within the 15 patch limit.

The driver and the selftests were developed with an LLM coding
assistant (Claude Code) working under my direction. I chose the
configfs design, the split into one feature per patch and the test
scenarios, and I reviewed every line. The assistant wrote most of the
code and the first drafts of the changelogs, and it found and fixed
bugs by running the suite on the lab host. The series then went
through several rounds of an LLM based patch reviewer whose findings
were fixed, and through a mutation test in which deliberately broken
driver and core code was caught by the tests.

The selftests live in tools/testing/selftests/drivers/dpll and run
with "make -C tools/testing/selftests TARGETS=drivers/dpll run_tests".
By default they create dpllsim devices; with DPLL_DEV_ID=<id> the basic
and feature scripts run against an existing device instead, so the same
suite exercises real hardware, and DPLL_DRIVER=<module name> picks the
first device of that driver, dpllsim for a simulated one. The whole
suite was run through the kselftest runner in a KVM guest and on an ice
E810 host with CONFIG_KASAN, CONFIG_PROVE_LOCKING and
CONFIG_DPLL_REFCNT_TRACKER enabled, against the simulator and, with
DPLL_DRIVER=ice, against the ice DPLL, where the tests that need a
simulator skip and the pin state and priorities of the hardware are
left as they were. All pass with no warnings in dmesg.

---
v3:
- move the selftests from tools/testing/selftests/drivers/net/dpll to
  tools/testing/selftests/drivers/dpll, with the shared library as a
  TEST_FILES entry of that directory, so that the tests sit where the
  drivers do
- let dpllsim refuse pin states that are not valid in the device mode:
  connected is refused in automatic mode, which the simulator runs in,
  as Documentation/driver-api/dpll.rst reserves it for manual mode
  (Ivan Vecera)
- make the pin state test follow the mode of the device under test and
  check on the simulator that connected is refused in automatic mode;
  cycle the stress tests through the states of automatic mode only
- add DPLL_DRIVER to pick the device of a given driver, or the simulator
  with DPLL_DRIVER=dpllsim, on a system that has hardware DPLL devices
- describe what the leak check waits for instead of a concurrent dump
  holding references, which nothing does (Ivan Vecera)
- carry the Reviewed-by and the set Acked-by of v2 over to the patches
  whose code did not change or only moved; patches 2, 5 and 6 changed
  and ask for a new look

v2:
- sort tools/testing/selftests/drivers/net/dpll/config alphabetically
  and make the scripts clean under the shellcheck run of the netdev CI
  (quoted exit and return values, shellcheck directives for the globals
  shared between the library and the scripts and for the optional
  argument of dpllsim_setup_standard_device())

v2: https://lore.kernel.org/all/20261105151852.1844305-1-poros@redhat.com/
v1: https://lore.kernel.org/all/20261103093910.596225-1-poros@redhat.com/
---
Petr Oros (14):
  dpll: dpllsim: Add simulated DPLL device driver
  selftests: dpll: add test library and device lifecycle tests
  dpll: dpllsim: Add configurable pins
  selftests: dpll: add pin enumeration and property tests
  dpll: dpllsim: Add support to set input pin state
  selftests: dpll: add pin state tests
  dpll: dpllsim: Add support to get/set priority on input pins
  selftests: dpll: add pin priority test
  dpll: dpllsim: Add support to set frequency on pins
  selftests: dpll: add pin frequency test
  dpll: dpllsim: Add support to adjust phase
  selftests: dpll: add pin phase adjust test
  selftests: dpll: add concurrency stress tests
  selftests: dpll: add reference leak tests

 Documentation/driver-api/dpllsim.rst          |  72 ++
 Documentation/driver-api/index.rst            |   1 +
 MAINTAINERS                                   |   8 +
 drivers/dpll/Kconfig                          |   1 +
 drivers/dpll/Makefile                         |   1 +
 drivers/dpll/dpllsim/Kconfig                  |  16 +
 drivers/dpll/dpllsim/Makefile                 |   4 +
 drivers/dpll/dpllsim/core.c                   | 471 ++++++++++
 drivers/dpll/dpllsim/dpll.c                   | 498 ++++++++++
 drivers/dpll/dpllsim/dpllsim.h                |  99 ++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/drivers/dpll/Makefile |  17 +
 tools/testing/selftests/drivers/dpll/config   |   6 +
 .../selftests/drivers/dpll/dpll_basic.sh      | 223 +++++
 .../selftests/drivers/dpll/dpll_features.sh   | 470 ++++++++++
 .../selftests/drivers/dpll/dpll_lib.sh        | 872 ++++++++++++++++++
 .../selftests/drivers/dpll/dpll_reftrack.sh   | 184 ++++
 .../selftests/drivers/dpll/dpll_stress.sh     | 563 +++++++++++
 tools/testing/selftests/drivers/dpll/settings |   1 +
 19 files changed, 3508 insertions(+)
 create mode 100644 Documentation/driver-api/dpllsim.rst
 create mode 100644 drivers/dpll/dpllsim/Kconfig
 create mode 100644 drivers/dpll/dpllsim/Makefile
 create mode 100644 drivers/dpll/dpllsim/core.c
 create mode 100644 drivers/dpll/dpllsim/dpll.c
 create mode 100644 drivers/dpll/dpllsim/dpllsim.h
 create mode 100644 tools/testing/selftests/drivers/dpll/Makefile
 create mode 100644 tools/testing/selftests/drivers/dpll/config
 create mode 100755 tools/testing/selftests/drivers/dpll/dpll_basic.sh
 create mode 100755 tools/testing/selftests/drivers/dpll/dpll_features.sh
 create mode 100644 tools/testing/selftests/drivers/dpll/dpll_lib.sh
 create mode 100755 tools/testing/selftests/drivers/dpll/dpll_reftrack.sh
 create mode 100755 tools/testing/selftests/drivers/dpll/dpll_stress.sh
 create mode 100644 tools/testing/selftests/drivers/dpll/settings

-- 
2.56.0

