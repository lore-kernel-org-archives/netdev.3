Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549827;
	b=KL+edx/Q1dzQAasrv3HOgWu7qQts8+UkJ4eBODtYBY0c5u5eYKeS9VJ7uTpZXTOUuzui
	 EuFg7MtBHbz9XdPfweeo2v3HqMuuH0g6U1MBYDvHp1PHy6sb56bxKjPgKXrhvCrhUqGnj
	 47URchUJsxqXs6j+lvsFUNekLLgPRZUVKDcHdxAdhH8nMfWaMK99GepjA/75p+FeiIckA
	 kx/GYnpZgGVtRt2U3FGLhV6HNKBZ2Co7453hcG3FHD/+m8C06vZbMD0cM1Knt0Z2yUQHb
	 2mTEFpxN8+l41xiWRoOu6yMSWAAovChoY7aVjO6Db8S5FIX2Xa06GaKi69FM421+r6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549827;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NvIhzZQf5UDJnO9c5CN0m5GvDC31vrAe1Cgg3SyZmPI=;
	b=JzkME4tKFvADm0+/sukrE9tLGFEKrhJCBrT1rlhGIMbltuWTqWx4WVW3KjYqpQCInvF8
	 ixmKEOKIxEitAPXYo1+G+pHnd1BH/qOt4ueEXtQ8lNeV47B0aIcLS5qvNc+Y21aPmiabw
	 0+LmcZ7dZNUbMy4ouRM4bSf61klxBseV2w35yccVz5lOMvG5Fnks+TFOAA9dkPy40Or5C
	 3IAEOiWk6GAX5kPPSyvIFqk7Pki8rbSuf2EtdsrhN8TbtdGh8A8ET6/ItbK38heU5P4SY
	 JuBVbxC9RHh6VnUyVeEeGsIBoH6hYtkhZCnll4nsmDXCvq+M5D+79yqO2Yiif7l9itg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKzpP+CA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3E606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKzpP+CA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352111F000C4;
	Fri, 13 Nov 2026 06:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549826;
	bh=NvIhzZQf5UDJnO9c5CN0m5GvDC31vrAe1Cgg3SyZmPI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HKzpP+CAXtuLONzX/frRtkegHUJc61HwzeB2N3dQiaaPgiKiQTVKoa4cMfAkPOeqx
	 tyb+n6cHMvvyin3v77VdTfSINrKFJKnw7uCnhoXd9g01a7C+vKYjAkvHBxhP1pRfbY
	 fH/pqOSOU7T2VpWcz8g4FgB1bZOrNhMVbqWsPIEwFddsWD0wtjK8By9PX0fPWv6b2f
	 5MT570h6Iw7seUCoYq+5AIOWYfK87vgDZQ68rDt6+X3v45iOz05SvcSiF54QkduBEi
	 CoFhmB0/kr0ZKRUjNiNF/MDRaTgQvCl8nwEoca5CALvC3tkCmkxG4pYh1jB5gKaNw1
	 IMdZCdd4UejzQ==
Subject: Re: [PATCH net-next v4 1/4] selftests: net: py: add metric output
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org
Date: Fri, 13 Nov 2026 06:03:45 +0000
Message-ID: <179454982577.2199510.14565556723328267605@kernel.org>
In-Reply-To: <20261111000246.962871-2-sdf@fomichev.me>
References: <20261111000246.962871-2-sdf@fomichev.me>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In tools/testing/selftests/net/lib/py/ksft.py, the ksft_metric()
  docstring ("They do not affect the result.") and…
- [Low] ksft_metric() in tools/testing/selftests/net/lib/py/ksft.py does
  not check that `goal` is one of "higher", "lower" or "zero", or that…
- [Low] tools/testing/selftests/drivers/net/README.rst now documents
  ksft_metric() under "Guidance for test authors", next to ksft_pr(),…

--

selftests: net: py: add metric output

This commit adds ksft_metric() to the Python net selftest library. The
helper prints a numeric measurement of the current test case as a compact
JSON line prefixed with "ktap-metric-json:", tagged with a goal of higher,
lower or zero. It is exported from net/lib/py and documented in
drivers/net/README.rst.

> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index 3fe49bce4f3a5..f651163c16c8c 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -259,6 +259,22 @@ ksft_pr()
>  
>  Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
>  
> +ksft_metric()
> +~~~~~~~~~~~~~
> +
> +Use ``ksft_metric()`` to report a numeric measurement of the current test
> +case. Metrics are printed right away as compact JSON. For example::

[Severity: Low]
Can tests in drivers/net/ and drivers/net/hw/ import this helper the way
the README suggests?

This section sits next to ksft_pr(), defer(), ksft_disruptive and
ksft_variants. All of those are re-exported by
drivers/net/lib/py/__init__.py and drivers/net/hw/lib/py/__init__.py.
Both files use an explicit import list and an explicit __all__:

    from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
        ksft_setup, ksft_variants, KsftNamedVariant

This patch only adds ksft_metric to net/lib/py/__init__.py. So a test in
drivers/net/ or drivers/net/hw/ that does "from lib.py import ksft_metric"
would fail with ImportError when the module loads.

Later patches in the series add drivers/net/perf/lib/py/__init__.py,
which does export ksft_metric. The drivers/net and drivers/net/hw libs
still don't export it at the end of the series.

Should those two re-export lists be updated as well?

[ ... ]

> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 81287c2daff09..572ee17b4f4f2 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py

[ ... ]

> @@ -93,6 +94,25 @@ def ksft_pr(*objs, **kwargs):
>      print(pfx, prefixed, **kwargs)
>  
>  
> +def ksft_metric(name, value, *, goal):
> +    """
> +    Report a numeric measurement of the current test case.
> +
> +    Metrics are printed right away. They do not affect the result.
> +
> +    Args:
> +      name - name of the metric, e.g. "throughput"
> +      value - the measured number
> +      goal - "higher" or "lower" for a performance metric, depending on
> +             which way is better, "zero" for an error metric, which must
> +             be zero
> +    """
> +    metric = {"name": name, "value": value, "goal": goal}

[Severity: Low]
This isn't a bug, but should ksft_metric() check that goal is one of
"higher", "lower" or "zero", and that value is a number?

Right now, a misspelled goal, a string or None value, or a bool (which
is encoded as true) still produces a well-formed ktap-metric-json line.
A consumer may not be able to classify that line.

The callers added later in the series, drivers/net/perf/iperf.py and
drivers/net/perf/devmem.py, both pass goal="higher" with a float
throughput. So this would only catch mistakes in future callers.

> +    payload = json.dumps(metric, allow_nan=False, separators=(",", ":"),
> +                         sort_keys=True)

[Severity: Low]
Is "They do not affect the result" true for every input?

With allow_nan=False, json.dumps() raises ValueError for NaN or
+/-Infinity, and TypeError for values it cannot encode. ksft_metric()
does not catch these, so they reach the generic handler in ksft_run():

        except BaseException as e:
            ...
            KSFT_RESULT = False
            cnt_key = 'fail'

The test case is then reported as failed. The README makes the same
claim: "Metrics do not affect the result of the test."

The callers in the series always pass finite throughput values. Also,
allow_nan=False looks like a deliberate choice to keep the output strict
JSON.

Could the docstring and the README say that non-finite or non-numeric
values raise an exception and fail the test case?

> +    ksft_pr(f"ktap-metric-json: {payload}")

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111000246.962871-1-sdf%40fomichev.me
