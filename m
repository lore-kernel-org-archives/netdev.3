Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698826;
	b=CLDXJ6ebzVAGm6IZmhOj2ZdPDob/lxVHUe1QWP41fYLAWC/ugu7URcql58tx8XX6yNVt
	 SCbOP4LlIe7pf2e8aUFFZql9EtnTaCObkyx5gIc7kOW+M5mj5KcN6mgcwwgFco1DYWiei
	 /TKnFNITsaKD+Q914G9mLJZEqIQzrdbydKMCep4xc2Por5pl2gjuQJUq6vrSF69FR2G2B
	 mPUPCBSse6pZUPyG/ArE3V40KzbtngoRinXBy7HiHA0EYhyGbxub2IBKFaSf/IK8Bb83g
	 lzxQecYpc+5wyka3Ne/Z4vd6f4sUPs1/EVzi9+hNQsrvZ0bKyARcbBWJvHEhSwzd76Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698826;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=p/ldGN+nO0FTKxlIwPgUvFWgOTT8F/z04T8/ZdFM2K4=;
	b=SNxWvAt/dgo2nRM7x1NwgHepuGbBKxa5WRicbSpKPSigjI5KeBLSYzBifhGRxUc7FyhL
	 3pjKlDEBvBGK5Suosl8IEt1EtdaON99oRmXcC+sqB29mcS//MRzdvNGQ1iCsz5YAVEcfq
	 uTmRgYfptbBWR/FwePyU7uMkjYb50Z3d0eLHixqHXJxBjDUNO6c9ib1o6sKcDO71BbTEU
	 gZmk0iOMr84ZyQx7KLQubIgfHjj/QoHgnQ5f5bYSdKQlLV4kFzOnwZtHslBrYXo/YSIjM
	 6zb58zjdHsmeHmQxlR0EBeTMqyU3wDolrtGGiSzKmYVXiF4yEx9gH4plpYRn/b2xWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fPsFX3D6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AE606D805
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F4AE606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fPsFX3D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/ldGN+nO0FTKxlIwPgUvFWgOTT8F/z04T8/ZdFM2K4=;
	b=fPsFX3D6Ry54DmHcugbCdET82pjviCGXxCpgeHyBmdPp0PbHDYesmd1h2PCRTcuwR4uff5
	2t7tOrsNp0WiuK34F7mt2MKoGUEnJkp5C8BbZgf35Vr9JhVyEqav0NRIrAT19TDpwLM8+W
	g+jFh93tw+pNDpNlis1JHTTumJQqy48=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-u41nQiapNtSKlbuYnRkd1A-1; Tue,
 03 Nov 2026 04:40:21 -0500
X-MC-Unique: u41nQiapNtSKlbuYnRkd1A-1
X-Mimecast-MFC-AGG-ID: u41nQiapNtSKlbuYnRkd1A_1793698820
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D55FD19539B4;
	Tue,  3 Nov 2026 09:40:19 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.42])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D43927F0;
	Tue,  3 Nov 2026 09:40:14 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH net-next 10/14] selftests: dpll: add pin frequency test
Date: Tue,  3 Nov 2026 10:39:06 +0100
Message-ID: <20261103093910.596225-11-poros@redhat.com>
In-Reply-To: <20261103093910.596225-1-poros@redhat.com>
References: <20261103093910.596225-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add a test that picks a supported frequency other than the current one
from the frequency-supported list of an input pin, sets it, reads it
back and restores the original value. Both ends of every advertised
range are candidates, so that a pin advertising a single range wider
than one value still has one. It skips when the dpll tool lacks the
frequency keyword of pin set, and the restore is deferred right after
the original value is read so that an interrupted run restores it too.
A pin that reports no frequency or advertises a single frequency only
is a skip on a device provided by the user and a failure on the device
the script created, whose pins advertise several.

The driver may refuse the candidate. A driver without a frequency
setter refuses every value with EOPNOTSUPP, and a driver with
constraints of its own refuses values the advertised ranges allow,
zl3073x for instance wants the frequencies of an output pair to divide
each other. On a device provided by the user a refused set is a skip
that names the reason the tool reported, which the setter keeps in
DPLL_LAST_ERR, on the created device the simulator accepts every
advertised value and the refusal is a failure. Once the set went
through, a refused restore is a failure on either.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 .../drivers/net/dpll/dpll_features.sh         | 64 +++++++++++++++++++
 .../selftests/drivers/net/lib/sh/dpll_lib.sh  |  5 ++
 2 files changed, 69 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/dpll/dpll_features.sh b/tools/testing/selftests/drivers/net/dpll/dpll_features.sh
index 941b7ee848f951..66e11f7f44eec9 100755
--- a/tools/testing/selftests/drivers/net/dpll/dpll_features.sh
+++ b/tools/testing/selftests/drivers/net/dpll/dpll_features.sh
@@ -17,6 +17,7 @@ source "$SCRIPTDIR/../lib/sh/dpll_lib.sh"
 ALL_TESTS="
 	test_pin_state_transitions
 	test_pin_priority_get_set
+	test_pin_frequency_set_get
 "
 
 ##############################################################################
@@ -165,6 +166,69 @@ test_pin_state_transitions()
 	log_test "DPLL pin state transitions"
 }
 
+test_pin_frequency_set_get()
+{
+	local before target after reason
+
+	RET=0
+
+	if [ -z "$PIN_TUNE_ID" ]; then
+		dpll_log_test_skip_or_fail "DPLL pin frequency set/get" \
+		    "no spare input pin"
+		return
+	fi
+	if ! dpll_pin_set_supports frequency; then
+		log_test_skip "DPLL pin frequency set/get" \
+		    "dpll tool lacks pin set frequency"
+		return
+	fi
+
+	before=$(dpll_pin_get_frequency "$PIN_TUNE_ID")
+	if [ -z "$before" ]; then
+		dpll_log_test_skip_or_fail "DPLL pin frequency set/get" \
+		    "frequency not reported"
+		return
+	fi
+	defer dpll_pin_set_frequency "$PIN_TUNE_ID" "$before"
+
+	# Pick a supported frequency different from the current one. Both
+	# ends of every supported range are candidates, so a pin with a
+	# single range still has an alternative unless it is one value wide.
+	target=$(dpll_pin_json "$PIN_TUNE_ID" | \
+		 jq -r --argjson cur "$before" \
+		    '[.["frequency-supported"][]? |
+		      .["frequency-min"], .["frequency-max"] |
+		      numbers | select(. != $cur)][0] // empty')
+	if [ -z "$target" ]; then
+		dpll_log_test_skip_or_fail "DPLL pin frequency set/get" \
+		    "no alternative supported frequency"
+		return
+	fi
+
+	# A driver without a frequency setter or with constraints of its own
+	# may refuse the candidate, a skip on a device the user provided, the
+	# simulator accepts every advertised value.
+	if ! dpll_pin_set_frequency "$PIN_TUNE_ID" "$target"; then
+		reason=${DPLL_LAST_ERR%%$'\n'*}
+		dpll_log_test_skip_or_fail "DPLL pin frequency set/get" \
+		    "cannot set frequency=$target${reason:+, $reason}"
+		return
+	fi
+	after=$(dpll_pin_get_frequency "$PIN_TUNE_ID")
+	if [ "$after" != "$target" ]; then
+		check_err 1 "frequency expected $target, got '$after'"
+	fi
+
+	dpll_pin_set_frequency "$PIN_TUNE_ID" "$before"
+	check_err $? "cannot restore frequency"
+	after=$(dpll_pin_get_frequency "$PIN_TUNE_ID")
+	if [ "$after" != "$before" ]; then
+		check_err 1 "frequency not restored, got '$after'"
+	fi
+
+	log_test "DPLL pin frequency set/get"
+}
+
 ##############################################################################
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh b/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
index 613ed365e3e311..191948442ef8bd 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
@@ -409,6 +409,11 @@ dpll_pin_set_prio()
 			     prio "$prio" 2>&1 >/dev/null)
 }
 
+dpll_pin_set_frequency()
+{
+	DPLL_LAST_ERR=$(dpll pin set id "$1" frequency "$2" 2>&1 >/dev/null)
+}
+
 ##############################################################################
 # dpllsim configfs interface
 #
-- 
2.56.0

