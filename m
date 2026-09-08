Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B100370ADC
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851585; cv=none; b=Oj40RV9/MbpSDD918LzuxskVYteiJ++GYvd+yNbJRD+oUgOD5HaonVPGd+UMg89P3GrsLYJHnNJsdQSQrBXzwwZKoghRETDbi8oVCQ0GF2LCHTw6YRE48bS7GPUHXmP8lEdJn2+wRIjQIs28is/sSRVqH63XY+d+/QD5R9yRc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851585; c=relaxed/simple;
	bh=pygZG/8vkCydWmwoKPql5XudN2mL9Ry4192w4Wj36dY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNB5v6sb24VTi8tO+M0445u2ipU3em+0lkWVO6USWgJP2Ce0vxrrmHnlD8rfSKC3lsJ39v34anvsbDJOwdzY9nUTzSCNJ8xJSsb6PthrBiFBApWOaInLQE8sFpNbd61+v/5B6JeHsCykqMa+CAgpgaxlKF6SVyRvUz0WkmCdlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY6NrppL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY6NrppL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6851D1F00A3A;
	Tue,  8 Sep 2026 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851584;
	bh=PrCL+ZS21DZRV6VrWMA3teIt40k+aKhLJBm7OgBkaBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mY6NrppLiy8ikq2Lw2DT4V2AhCsC09Zn5o9Cxa1PkKHop+42EJFuOLsNXR5XPSsL/
	 ACQwRBdyflXyN/sm3RbOn5kkptiOO6dI33ciCldQAeE+akCwqETlzpIBtl99hIaKXl
	 vyNcv1MviTQq63FXq1eDsujBb5MQNKe1L7GDOF2GfkoWcHVKU5iuMlcriFJSP3zmaU
	 keQLjIWLChRg1rOKum5gzrCF1QA8VrZmudJbfn5Fh8gx7hZjVHRKi7PA1fa1yvlTWU
	 HGrGvNA4fuSJ7kHvw49MEukBTIfVzBU+4R5DumkaaQ8rVRS1Aab7rMoSxwOUIiS3Zh
	 qMo3K798/Jy9w==
Subject: Re: [PATCH net-next 1/4] netlink: specs: dpll: add
 clock-quality-level to the device-get reply
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, ivecera@redhat.com,
 jiri@resnulli.us, donald.hunter@gmail.com
Date: Tue, 08 Sep 2026 07:13:02 +0000
Message-ID: <178885158293.219967.4041020024393917089@kernel.org>
In-Reply-To: <20260904191023.3869690-2-kuba@kernel.org>
References: <20260904191023.3869690-2-kuba@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] Documentation/netlink/specs/dpll.yaml: the patch repairs a user-
  visible uAPI-description defect (the &dev-attrs reply anchor of…

Pre-existing issues:
- [Low] The hand-written DPLL ABI table in Documentation/driver-
  api/dpll.rst (``DPLL_CMD_DEVICE_GET`` section, lines ~382-395) still…

--

netlink: specs: dpll: add clock-quality-level to the device-get reply

The device-get reply anchor (&dev-attrs) in the dpll YAML spec was missing
clock-quality-level, even though dpll_device_get_one() puts
DPLL_A_CLOCK_QUALITY_LEVEL into every device-get reply, dump entry and
device-*-ntf for drivers implementing clock_quality_level_get(). The patch
adds the missing entry to the reply list.

> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index cdc8c7b456df8..64a45088c0273 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -632,6 +632,7 @@ operations:
>              - mode-supported
>              - lock-status
>              - lock-status-error
> +            - clock-quality-level

[Severity: Low]
The commit message names the culprit in prose:

  "Missing since commit a1afb959add1 ("dpll: add clock quality level
  attribute and op")"

but there is no Fixes: tag. Since this changes what the generated ynl
bindings parse (struct dpll_device_get_rsp gains a field for
DPLL_A_CLOCK_QUALITY_LEVEL that dpll_device_get_rsp_parse() previously
dropped), would a machine-readable tag be preferable here so backport
tooling picks it up?

  Fixes: a1afb959add1 ("dpll: add clock quality level attribute and op")

[Severity: Low]
This isn't something introduced by this patch, but there is a second,
hand-written description of the same reply that stays narrower than what
the kernel emits. The ``DPLL_CMD_DEVICE_GET`` table in
Documentation/driver-api/dpll.rst lists only:

    ``DPLL_A_ID``
    ``DPLL_A_MODULE_NAME``
    ``DPLL_A_CLOCK_ID``
    ``DPLL_A_MODE``
    ``DPLL_A_MODE_SUPPORTED``
    ``DPLL_A_LOCK_STATUS``
    ``DPLL_A_TEMP``
    ``DPLL_A_TYPE``

while dpll_device_get_one() also puts DPLL_A_CLOCK_QUALITY_LEVEL,
DPLL_A_LOCK_STATUS_ERROR, DPLL_A_PHASE_OFFSET_MONITOR,
DPLL_A_PHASE_OFFSET_AVG_FACTOR and DPLL_A_FREQUENCY_MONITOR into the
message.

The commit message says "dpll.rst does not document it", which reads as the
ynl-generated Documentation/networking/netlink_spec/dpll.rst and is indeed
fixed by this YAML change.

Should the driver-api table get the same treatment, or is it intended to
be superseded by the generated spec documentation?

>              - temp
>              - clock-id
>              - type

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904191023.3869690-1-kuba%40kernel.org
